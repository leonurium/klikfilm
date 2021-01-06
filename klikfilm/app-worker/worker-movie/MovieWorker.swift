//
//  MovieWorker.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import Foundation

class MovieWorker {
    static let shared = MovieWorker()
    
    func getDiscoverMovie(page: Int? = 1, completion: @escaping (Result<MoviesResponse, Error>) -> Void) {
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "api_key", value: APIConstant.api_key_tmdb.rawValue))
        queryItems.append(URLQueryItem(name: "page", value: "\(page ?? 1)"))
        
        var urlComponent = URLComponents(string: URLConst.api_discover + "movie")
        urlComponent?.queryItems = queryItems
        let url = urlComponent?.url?.absoluteString ?? ""
        
        HTTPRequest.shared.connect(url: url, params: nil, model: MoviesResponse.self) { (result) in
            completion(result)
        }
    }
}
