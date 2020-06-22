//
//  FavouriteAPI.swift
//  Movies
//
//  Created by Juan Carlos on 20/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import UIKit
import CloudKit
import CoreData

// MARK: - MovieAPI Extension
extension MovieAPI {

    /**
        The favourite function check if a movie is in your favourite database.

        An example use of isFavourite:

            API.movie.isFavourite(movie) {}
    */
    @available(iOS 13.0, *)
    func isFavourite(_ movie: Movie) -> Bool {
        do {
            let results: [FavouriteMovie] = try NSManagedObject.query(table: "FavouriteMovie", searchPredicate: NSPredicate(format: "ANY movieID IN %@ AND favourite == 1", [movie.id]))

            return results.count > 0
        } catch let error {
            debugPrint(error)
            return false
        }
    }

    /**
        The favourite function gets a movie in from favourite database.

        An example use of get:

            API.movie.get(movie) {}
    */
    @available(iOS 13.0, *)
    func get(_ movie: Movie) -> FavouriteMovie? {
        do {
            let results: [FavouriteMovie] = try NSManagedObject.query(table: "FavouriteMovie", searchPredicate: NSPredicate(format: "ANY movieID IN %@", [movie.id]))

            return results.first
        } catch let error {
            debugPrint(error)
            return nil
        }
    }

    /**
        The favourite function saves a movie in your favourite database.

        An example use of favourite:

            API.movie.favourite(movie) {}
    */
    @available(iOS 13.0, *)
    func favourite(_ movie: Movie, completed: @escaping (Result<FavouriteMovie, Error>) -> Void) {
        DispatchQueue.main.async {
            do {
                let context = AppDelegate.current().persistentContainer.viewContext
                let encoded = try JSONEncoder().encode(movie)
                guard let data = String(data: encoded, encoding: .utf8) else {
                    completed(.failure(ImplementationError.dataError))
                    return
                }

                let movieRecord = FavouriteMovie(context: context)
                movieRecord.movieID = Int64(movie.id)
                movieRecord.data = data
                movieRecord.favourite = true

                try context.save()
                completed(.success(movieRecord))
            } catch let error {
                debugPrint(error)
                completed(.failure(error))
            }
        }
    }

    /**
        The unfavourite function deletes a movie in your unfavourite database.

        An example use of unfavourite:

            API.movie.unfavourite(movie) {}
    */
    @available(iOS 13.0, *)
    func unfavourite(_ movie: FavouriteMovie, completed: @escaping (Result<FavouriteMovie, Error>) -> Void) {
        DispatchQueue.main.async {
            do {
                let context = AppDelegate.current().persistentContainer.viewContext
                movie.favourite = false

                try context.save()
                completed(.success(movie))
            } catch let error {
                debugPrint(error)
                completed(.failure(error))
            }
        }
    }

    /**
        The allfavourite function gets all the movies in your favourite database.

        An example use of allfavourite:

            API.movie.allfavourite(movie) {}
    */
    @available(iOS 13.0, *)
    func allfavourite(completed: @escaping (Result<[Movie], Error>) -> Void) {

        DispatchQueue.main.async {
            do {
                let results: [FavouriteMovie] = try NSManagedObject.query(table: "FavouriteMovie", searchPredicate: NSPredicate(format: "ANY favourite == %@", "1"))
                let movies = results.serializeMovies()
                completed(.success(movies))
            } catch let error {
                debugPrint(error)
                completed(.failure(error))
            }
        }

    }
}
