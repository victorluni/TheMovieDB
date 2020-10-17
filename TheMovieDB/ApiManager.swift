//
//  ApiManager.swift
//  TheMovieDB
//
//  Created by Victor Luni on 04/10/20.
//

import Foundation


enum ApiValues: String {

    case genres
    case nowPlaying
    case moviesByGenre
    
    func nextPage(page: Int) -> String {
        switch self {
        case .nowPlaying:
            return "\(Constants.baseURL)/movie/now_playing?api_key=\(Constants.authKey)&language=en-US&page=\(page)"
        case .moviesByGenre:
            return "\(Constants.baseURL)/discover/movie?api_key=\(Constants.authKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)&with_genres="
        default:
            return ""
        }
    }
    
    func getURL() -> String {
        switch self {
        case .genres:
            return "\(Constants.baseURL)/genre/movie/list?api_key=\(Constants.authKey)&language=en-US"
        case .nowPlaying:
            return "\(Constants.baseURL)/movie/now_playing?api_key=\(Constants.authKey)&language=en-US&page=1"
        case .moviesByGenre:
            return "\(Constants.baseURL)/discover/movie?api_key=\(Constants.authKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres="
        default:
            return ""
        }
    }
}


class ApiManager<DataContent> where DataContent: Decodable {
    
    
    func getDataGenerics(from: String, completion: @escaping (DataContent) -> ()) {
        if let url = URL(string: from) {
            URLSession.shared.dataTask(with: url) { data, res, err in
                if let response = data {
                    guard let unwrapped = self.decodeGeneric(data: response) else {
                        fatalError()
                    }
                    completion(unwrapped)
                }
            }.resume()
        }
    }
    
    func decodeGeneric(data: Data) -> DataContent? {
        do {
            let result = try JSONDecoder().decode(DataContent.self, from: data)
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
}

class Constants {
    static let authKey = "authKey"
    static let baseURL = "https://api.themoviedb.org/3"
}
