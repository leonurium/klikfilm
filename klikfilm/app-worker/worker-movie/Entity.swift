//
//  Entity.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import Foundation

import Foundation

struct MoviesResponse: Codable {
    let page            : Int
    let total_results   : Int
    let total_pages     : Int
    let results         : [MovieItem]
    
    enum Keys: String, CodingKey {
        case page, total_results, total_pages, results
    }
    
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: Keys.self)
        self.page           = try container.decodeIfPresent(Int.self, forKey: .page) ?? 0
        self.total_results  = try container.decodeIfPresent(Int.self, forKey: .total_results) ?? 0
        self.total_pages    = try container.decodeIfPresent(Int.self, forKey: .total_pages) ?? 0
        self.results        = try container.decodeIfPresent([MovieItem].self, forKey: .results) ?? []
    }
}

struct MovieItem: Codable {
    let popularity          : Float
    let vote_count          : Int
    let video               : Bool
    let poster_path         : String
    let backdrop_path       : String
    let id                  : Int
    let adult               : Bool
    let original_language   : String
    let original_title      : String
    let genre_ids           : [Int]
    let title               : String
    let vote_average        : Float
    let overview            : String
    let release_date        : String
    
    enum Keys: String, CodingKey {
        case popularity, vote_count, video, poster_path, backdrop_path, id, adult
        case original_language, original_title, genre_ids, title, vote_average, overview, release_date
    }
    
    init(from decoder: Decoder) throws {
        let container           = try decoder.container(keyedBy: Keys.self)
        self.popularity         = try container.decodeIfPresent(Float.self, forKey: .popularity) ?? 0.0
        self.vote_count         = try container.decodeIfPresent(Int.self, forKey: .vote_count) ?? 0
        self.video              = try container.decodeIfPresent(Bool.self, forKey: .video) ?? false
        self.poster_path        = try container.decodeIfPresent(String.self, forKey: .poster_path) ?? ""
        self.backdrop_path      = try container.decodeIfPresent(String.self, forKey: .backdrop_path) ?? ""
        self.id                 = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.adult              = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? false
        self.original_language  = try container.decodeIfPresent(String.self, forKey: .original_language) ?? ""
        self.original_title     = try container.decodeIfPresent(String.self, forKey: .original_title) ?? ""
        self.genre_ids          = try container.decodeIfPresent([Int].self, forKey: .genre_ids) ?? []
        self.title              = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.vote_average       = try container.decodeIfPresent(Float.self, forKey: .vote_average) ?? 0.0
        self.overview           = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        self.release_date       = try container.decodeIfPresent(String.self, forKey: .release_date) ?? ""
    }
}

enum PosterSize: String {
    case w92, w154, w185, w342, w500, w780, original
}

struct VideoResponse: Codable {
    let id      : Int
    let results : [VideoItem]
}

struct VideoItem: Codable {
    let id          : String
    let iso_639_1   : String
    let iso_3166_1  : String
    let key         : String
    let name        : String
    let site        : String
    let size        : Int
    let type        : String
}

struct ReviewResponse: Codable {
    let id : Int
    let page : Int
    let total_pages : Int
    let total_results : Int
    let results : [ReviewItem]
}

struct ReviewItem: Codable {
    let id: String
    let author: String
    let author_details: Author
    let content: String
    let created_at: String
    let updated_at: String
    let url: String
}

struct Author: Codable {
    let name : String
    let username: String
    let avatar_path: String
    let rating: Int
}
