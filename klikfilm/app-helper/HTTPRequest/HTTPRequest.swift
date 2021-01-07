//
//  HTTPRequest.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit
import FirebaseCrashlytics

protocol HTTPRequestDelegate: class {
    func didGetError(error: Error, http: HTTPRequest)
    func didGetProgress(_ progress: Float, http: HTTPRequest)
    func didGetData(data: Data, http: HTTPRequest)
}

class HTTPGenericTask {
    private(set) var task: URLSessionTask
    var ID: String?
    var progressHandler: ((_ size: Float) -> Void)?
    
    init(task: URLSessionTask) {
        self.task = task
    }
    
    deinit {
        debugLog("Deinit : \(task.originalRequest?.url?.absoluteString ?? "")")
    }
    
    func resume() {
        task.resume()
    }
    
    func suspend() {
        task.suspend()
    }
    
    func cancel() {
        task.cancel()
    }
}

class HTTPRequest: NSObject {
    static let shared: HTTPRequest = {
        return HTTPRequest()
    }()
    
    private var tasks: [HTTPGenericTask] = []
    var session: URLSession!
    let task = URLSession.shared
    var timeoutInterval: TimeInterval = 60
    var headers: [HTTPRequestHeader.key : String] = [:]
    var method: HTTPRequestMethod?
    var progressHandler: ((_ progress: Float, _ size: Float) -> Void)?
    weak var delegate: HTTPRequestDelegate?
    
    init(delegate on: HTTPRequestDelegate? = nil, inBackground: Bool = false, delegate queue: OperationQueue? = nil) {
        super.init()
        self.delegate = on
        if inBackground {
            session = URLSession(
                configuration: .background(withIdentifier: "\(Bundle.main.bundleIdentifier ?? String(describing: HTTPRequest.self)).background"),
                delegate: self,
                delegateQueue: queue
            )
        } else {
            session = URLSession(configuration: .default)
        }
    }
    
    private func resetValueToDefault() {
        timeoutInterval = 60
        headers.removeAll()
        method = nil
        progressHandler = nil
    }
    
    func uploadInBackground(fromURL: URL, url: String, params: [String:Any]?) -> HTTPGenericTask {
        guard let _url = URL(string: url) else {
            fatalError("invalid url: " + url)
        }
        
        var request = URLRequest(url: _url)
        request.httpMethod = params == nil ? "GET" : "POST"
        request.timeoutInterval = self.timeoutInterval
        
        if headers.count > 0 {
            headers.forEach { (k, v) in
                request.addValue(v, forHTTPHeaderField: k.string)
            }
        }
        
        if let _method = self.method {
            request.httpMethod = _method.rawValue
        }
        
        if let param = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: param, options:[])
            } catch let e {
                debugLog(e.localizedDescription)
                delegate?.didGetError(error: e, http: self)
            }
        }
        
        let task = session.uploadTask(with: request, fromFile: fromURL)
        let genericTask = HTTPGenericTask(task: task)
        tasks.append(genericTask)
        genericTask.resume()
        resetValueToDefault()
        return genericTask
    }
    
    func upload<T:Decodable>(fileURL: URL, url: String, params: [String:Any]?, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        guard let _url = URL(string: url) else {
            fatalError("invalid url: " + url)
        }
        
        var request = URLRequest(url: _url)
        request.httpMethod = params == nil ? "GET" : "POST"
        request.timeoutInterval = self.timeoutInterval
        
        if headers.count > 0 {
            headers.forEach { (k, v) in
                request.addValue(v, forHTTPHeaderField: k.string)
            }
        }
        
        if let _method = self.method {
            request.httpMethod = _method.rawValue
        }
        
        if let param = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: param, options:[])
            } catch let e {
                debugLog(e.localizedDescription)
                completion(.failure(e))
            }
        }
        
        task.uploadTask(with: request, fromFile: fileURL) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let responses = response as? HTTPURLResponse {
                    debugLog("status code", responses.statusCode)
                    
                    if let _data = data, let stringResponse = String(data: _data, encoding: .utf8) {
                        debugLog(stringResponse)
                        Crashlytics.crashlytics().log(stringResponse)
                        
                        if responses.statusCode != 200 {
                            let e = NSError(domain: "Status Code", code: responses.statusCode, userInfo: nil)
                            completion(.failure(e))
                            return
                        }
                        
                        do {
                            let responseModel = try JSONDecoder().decode(T.self, from: _data)
                            completion(.success(responseModel))
                        } catch let jsonError {
                            completion(.failure(jsonError))
                        }
                    }
                }
            }
        }.resume()
        resetValueToDefault()
    }
    
    func upload<T:Decodable>(data: Data, url: String, params: [String:Any]?, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        guard let _url = URL(string: url) else {
            fatalError("invalid url: " + url)
        }
        
        var request = URLRequest(url: _url)
        request.httpMethod = params == nil ? "GET" : "POST"
        request.timeoutInterval = self.timeoutInterval
        
        if headers.count > 0 {
            headers.forEach { (k, v) in
                request.addValue(v, forHTTPHeaderField: k.string)
            }
        }
        
        if let _method = self.method {
            request.httpMethod = _method.rawValue
        }
        
        if let param = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: param, options:[])
            } catch let e {
                debugLog(e.localizedDescription)
                completion(.failure(e))
            }
        }
        
        task.uploadTask(with: request, from: data) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let responses = response as? HTTPURLResponse {
                    debugLog("status code", responses.statusCode)
                    
                    if let _data = data, let stringResponse = String(data: _data, encoding: .utf8) {
                        debugLog(stringResponse)
                        Crashlytics.crashlytics().log(stringResponse)
                        
                        if responses.statusCode != 200 {
                            let e = NSError(domain: "Status Code", code: responses.statusCode, userInfo: nil)
                            completion(.failure(e))
                            return
                        }
                        
                        do {
                            let responseModel = try JSONDecoder().decode(T.self, from: _data)
                            completion(.success(responseModel))
                        } catch let jsonError {
                            completion(.failure(jsonError))
                        }
                    }
                }
            }
        }.resume()
        resetValueToDefault()
    }
    
    func connect<T:Decodable>( url: String, params: [String:Any]?, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let _url = URL(string: url) else {
            fatalError("invalid url: " + url)
        }
        
        var request = URLRequest(url: _url)
        request.httpMethod = params == nil ? "GET" : "POST"
        request.timeoutInterval = self.timeoutInterval
        
        if headers.count > 0 {
            headers.forEach { (k, v) in
                request.addValue(v, forHTTPHeaderField: k.string)
            }
        }
        
        if let _method = self.method {
            request.httpMethod = _method.rawValue
        }
        
        if let param = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: param, options:[])
            } catch let e {
                debugLog(e.localizedDescription)
                completion(.failure(e))
            }
        }
        
        self.task.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let responses = response as? HTTPURLResponse {
                    debugLog("status code", responses.statusCode)
                    
                    if let _data = data, let stringResponse = String(data: _data, encoding: .utf8) {
                        debugLog(stringResponse)
                        Crashlytics.crashlytics().log(stringResponse)
                        
                        if responses.statusCode != 200 {
                            let e = NSError(domain: "Status Code", code: responses.statusCode, userInfo: nil)
                            completion(.failure(e))
                            return
                        }
                        
                        do {
                            let responseModel = try JSONDecoder().decode(T.self, from: _data)
                            completion(.success(responseModel))
                        } catch let jsonError {
                            completion(.failure(jsonError))
                        }
                    }
                }
            }
        }.resume()
        resetValueToDefault()
    }
}

extension HTTPRequest {
    func parseDataToModel<T:Decodable>(data: Data, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let responseModel = try JSONDecoder().decode(T.self, from: data)
            completion(.success(responseModel))
        } catch let jsonError {
            completion(.failure(jsonError))
            delegate?.didGetError(error: jsonError, http: self)
        }
    }
    
    func getGenericTasks() -> [HTTPGenericTask] { return self.tasks }
}

extension HTTPRequest: URLSessionDelegate {
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        guard let err = error else { return }
        delegate?.didGetError(error: err, http: self)
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            if
                let app = UIApplication.shared.delegate as? AppDelegate,
                let completionHandler = app.backgroundSessionCompletionHandler {
                app.backgroundSessionCompletionHandler = nil
                completionHandler()
            }
        }
    }
}

extension HTTPRequest: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let uploadProgress:Float =  Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        progressHandler?(uploadProgress, Float(bytesSent))
        debugLog(uploadProgress, "progressHandler")
        delegate?.didGetProgress(uploadProgress, http: self)
        guard let taskSession = tasks.first(where: {$0.task == task}) else { return }
        taskSession.progressHandler?(uploadProgress)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        let response = task.response
        if let a = response as? HTTPURLResponse {
            debugLog("status code: ", a.statusCode)
            if a.statusCode != 200 {
                let e = NSError(domain: "Status Code", code: a.statusCode, userInfo: nil)
                delegate?.didGetError(error: e, http: self)
                return
            }
        }
        
        if let index = tasks.firstIndex(where: {$0.task == task}) {
            tasks.remove(at: index)
            if let err = error {
                delegate?.didGetError(error: err, http: self)
            }
        }
    }
}

extension HTTPRequest: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard tasks.firstIndex(where: {$0.task == dataTask}) != nil else {
            completionHandler(.cancel)
            debugLog("----canceled")
            return
        }
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let stringResponse = String(data: data, encoding: .utf8) {
            debugLog(stringResponse)
            Crashlytics.crashlytics().log(stringResponse)
        }
        delegate?.didGetData(data: data, http: self)
    }
}
