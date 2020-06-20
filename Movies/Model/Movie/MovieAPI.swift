//
//  MovieAPI.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import CloudKit

class MovieAPI {
    
    internal let database: CKDatabase = CKContainer.default().privateCloudDatabase
    
    public init() {
        debugPrint("MovieListAPI")
    }
    
    func find(id: Int, completed: @escaping (Result<Movie, Error>) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)\(API.settings.apiKey)"
        
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
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                
                completed(.success(movie))
            } catch let jsonError {
                completed(.failure(jsonError))
            }
        }.resume()
    }
}
