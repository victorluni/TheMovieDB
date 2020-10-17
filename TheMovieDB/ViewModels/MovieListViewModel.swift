//
//  MovieListViewModel.swift
//  TheMovieDB
//
//  Created by Victor Luni on 06/10/20.
//

import Foundation


class MovieListViewModel {
    
    private var movieList: MovieList?
    
    var movies: [Movie]? {
        return movieList?.movies
    }
    
    var page: Int? {
        return movieList?.page
    }
    
    var filteredMovies: [Movie] = []
    var isEmpty = true
    
    
    func fetchNowPlaying(completion: @escaping (MovieListViewModel, Error?) -> Void) {
        ApiManager<MovieList>().getDataGenerics(from: ApiValues.nowPlaying.getURL()) { (data) in
            DispatchQueue.main.async {
                self.movieList = data
                completion(self, nil)
            }
        }
    }
    
    func fetchMoviesByGenre(id: Int, completion: @escaping (MovieListViewModel, Error?) -> Void) {
        ApiManager<MovieList>().getDataGenerics(from: ApiValues.moviesByGenre.getURL() + String(id)) { (data) in
            DispatchQueue.main.async {
                self.movieList = data
                completion(self, nil)
            }
        }
    }
    
    func fetchNextPage(url: ApiValues, page: Int, completion: @escaping (MovieListViewModel, Error?) -> Void) {
        ApiManager<MovieList>().getDataGenerics(from: url.nextPage(page: page)) { (data) in
            DispatchQueue.main.async {
                self.movieList?.movies.append(contentsOf: data.movies)
                completion(self, nil)
            }
        }
    }
    
    
    func filterArray(text: String, completion: @escaping (MovieListViewModel, Error?) -> Void) {
        guard let movies = self.movieList?.movies else {
            return
        }
        
        if isEmpty {
            filteredMovies = self.movieList?.movies ?? []
        }
        
        if text != "" {
            isEmpty = false
            self.movieList?.movies = movies.filter({$0.title.hasPrefix(text)})
        } else {
            self.movieList?.movies = filteredMovies
        }
        completion(self, nil)
    }
    
}
