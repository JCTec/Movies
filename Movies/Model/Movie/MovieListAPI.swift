//
//  MovieListAPI.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - MovieListAPI
class MovieListAPI {

    public init() {
        debugPrint("MovieListAPI")
    }

    /**
        This functions lets you search a movie in the database given a String representing a Query.

        An example use of search:

            API.movie.search("Hello") {}
    */
    func search(_ page: Int = 1, query: String, completed: @escaping (Result<[Movie], Error>) -> Void) {
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            completed(.failure(ImplementationError.urlError))
            return
        }

        let url = "https://api.themoviedb.org/3/search/movie\(API.settings.apiKey)&query=\(safeQuery)\(String.page(page))"

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

    /**
        This functions lets you get a list of movies depending of MovieListIdentifier.

        An example use of ofType:

            API.movie.ofType(.nowPlaying) {}
    */
    func ofType(page: Int = 1, _ type: MovieListIdentifier, completed: @escaping (Result<[Movie], Error>) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(type.rawValue)\(API.settings.apiKey)\(String.page(page))"

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
