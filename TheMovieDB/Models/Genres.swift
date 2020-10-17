//
//  Genres.swift
//  TheMovieDB
//
//  Created by Victor Luni on 04/10/20.
//

import Foundation

struct Genres: Codable {
    var list: [GenreBody]
    
    enum CodingKeys: String, CodingKey {
        case list = "genres"
    }
}

struct GenreBody: Codable {
    var id: Int
    var name: String
}
