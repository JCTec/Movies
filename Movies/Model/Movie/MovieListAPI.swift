//
//  MovieListAPI.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

class MovieListAPI {
    
    public init() {
        debugPrint("MovieListAPI")
    }
    
    func search(query: String, completed: @escaping (Result<[Movie], Error>) -> Void) {
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            completed(.failure(ImplementationError.urlError))
            return
        }
        
        let url = "https://api.themoviedb.org/3/search/movie\(API.settings.apiKey)&query=\(safeQuery)"
        
        guard let urlRequest: URLRequest = API.urlRequest(url, httpMethod: .get) else {
            completed(.failure(ImplementationError.unrecognized))
            return
        }

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            if let err = error {
                completed(.failure(err))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completed(.failure(ServerError.badRequest))
                return
            }
            
            guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                completed(.failure(ServerError.badRequest))
                return
            }
            
            guard let data = data else {
                completed(.failure(ImplementationError.dataError))
                return
            }
            
            do {
                try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let movie = try JSONDecoder().decode(MovieResultData.self, from: data)
                
                completed(.success(movie.results))
            } catch let jsonError {
                completed(.failure(jsonError))
            }
        }.resume()
    }
    
    func ofType(_ type: MovieListIdentifier, completed: @escaping (Result<[Movie], Error>) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(type.rawValue)\(API.settings.apiKey)"
        
        guard let urlRequest: URLRequest = API.urlRequest(url, httpMethod: .get) else {
            completed(.failure(ImplementationError.unrecognized))
            return
        }

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            debugPrint(url)
            debugPrint(data?.toString() ?? "No Data")
            
            if let err = error {
                completed(.failure(err))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completed(.failure(ServerError.badRequest))
                return
            }
            
            guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                completed(.failure(ServerError.badRequest))
                return
            }
            
            guard let data = data else {
                completed(.failure(ImplementationError.dataError))
                return
            }
            
            do {
                try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                if type == .latest {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    
                    completed(.success([movie]))
                }else {
                    let movie = try JSONDecoder().decode(MovieResultData.self, from: data)
                    
                    completed(.success(movie.results))
                }
            } catch let jsonError {
                completed(.failure(jsonError))
            }
        }.resume()
    }
}
