//
//  MovieDetailViewModel.swift
//  TheMovieDB
//
//  Created by Victor Luni on 06/10/20.
//

import Foundation

class MovieDetailViewModel {
    
    private var movie: Movie?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        self.movie?.originalTitle ?? ""
    }
    
    var description: String {
        self.movie?.overview ?? ""
    }
    
    var imageURL: String {
        imageUrl()
    }
    
    private func imageUrl() -> String {
        guard let path = self.movie?.posterPath else { return ""}
        return "https://image.tmdb.org/t/p/w780\(path)"
    }
    
}
