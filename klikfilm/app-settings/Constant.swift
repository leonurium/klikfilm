//
//  Constant.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import Foundation

struct URLConst {
    static let server       = "https://api.themoviedb.org/"
    static let version_api  = "3/"
    static let api_url      = server + version_api
    static let api_poster   = "https://image.tmdb.org/t/p/"
    static let api_avatar   = "https://secure.gravatar.com/avatar/"
    
    static let api_genre    = api_url + "genre/"
    static let api_discover = api_url + "discover/"
    static let api_movie    = api_url + "movie/"
}

enum APIConstant: String {
    case api_key_tmdb = "8900a92c57ce86f7c50a7e135e848eb4"
}
