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
    
    func getReview(page: Int? = 1, movie_id: Int, completion: @escaping (Result<ReviewResponse, Error>) -> Void) {
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "api_key", value: APIConstant.api_key_tmdb.rawValue))
        queryItems.append(URLQueryItem(name: "page", value: "\(page ?? 1)"))
        
        var urlComponent = URLComponents(string: URLConst.api_movie + "\(movie_id)/reviews")
        urlComponent?.queryItems = queryItems
        let url = urlComponent?.url?.absoluteString ?? ""
        
        HTTPRequest.shared.connect(url: url, params: nil, model: ReviewResponse.self) { (result) in
            completion(result)
        }
    }
    
    func getVideos(movie_id: Int, completion: @escaping (Result<VideoResponse, Error>) -> Void) {
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "api_key", value: APIConstant.api_key_tmdb.rawValue))
        
        var urlComponent = URLComponents(string: URLConst.api_movie + "\(movie_id)/videos")
        urlComponent?.queryItems = queryItems
        let url = urlComponent?.url?.absoluteString ?? ""
        
        HTTPRequest.shared.connect(url: url, params: nil, model: VideoResponse.self) { (result) in
            completion(result)
        }
    }
}
