//
//  GenreAPI.swift
//  Movies
//
//  Created by Juan Carlos on 22/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - GenreAPI
class GenreAPI {
    
    public init() {
        debugPrint("GenreAPI")
    }
    
    func setGenreFromIds(_ movie: Movie, completed: @escaping (Movie) -> Void) {
        guard let ids = movie.genreIDs else {
            completed(movie)
            return
        }
        
        let group = DispatchGroup()
        var genres = [Genre]()
        
        for id in ids {
            group.enter()
            find(id: id) { (result) in
                switch result {
                    case .success(let genre):
                        genres.append(genre)
                    case .failure(let error):
                        debugPrint(error)
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            var m = movie
            m.genres = genres
            completed(m)
        }
    }
    
    /**
        The find function returns a Genre given its database ID.

        An example use of find:

            API.movie.find(id: 1234) {}
    */
    func find(id: Int, completed: @escaping (Result<Genre, Error>) -> Void) {
        
        let cacheGenreKey = GenreCache(id: id)
        
        if let cacheGenre: Genre = API.settings.cache.load(cacheGenreKey) {
            completed(.success(cacheGenre))
            return
        }
        
        let url = "https://api.themoviedb.org/3/genre/\(id)\(API.settings.apiKey)"
        
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
                let movie = try JSONDecoder().decode(Genre.self, from: data)
                
                API.settings.cache.save(cacheGenreKey, data: data)
                
                completed(.success(movie))
            } catch let jsonError {
                completed(.failure(jsonError))
            }
        }.resume()
    }
}
