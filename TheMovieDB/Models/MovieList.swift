//
//  NowPlaying.swift
//  TheMovieDB
//
//  Created by Victor Luni on 05/10/20.
//

import Foundation

struct MovieList: Codable {
    var page: Int
    var movies: [Movie]
    var dates: Dates?
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case movies = "results"
        case dates = "dates"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Dates: Codable {
    var maximum: String
    var minimum: String
}
