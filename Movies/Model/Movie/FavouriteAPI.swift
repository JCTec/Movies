//
//  FavouriteAPI.swift
//  Movies
//
//  Created by Juan Carlos on 20/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import CloudKit

extension MovieAPI {
            
    func favourite(_ movie: Movie, completed: @escaping (Result<CKRecord, Error>) -> Void) {
        do {
            let encoded = try JSONEncoder().encode(movie)
            let data = String(data: encoded, encoding: .utf8)
            
            let movieRecord = CKRecord(recordType: "Movies")
            movieRecord.setValue(movie.id, forKey: "movieID")
            movieRecord.setValue(data, forKey: "data")
            movieRecord.setValue(true, forKey: "favourite")

            database.save(movieRecord) { (record, error) in
                if let error = error {
                    completed(.failure(error))
                    return
                }
                
                guard let record = record else {
                    completed(.failure(CKError.unrecognized))
                    return
                }
                
                completed(.success(record))
            }
        } catch let error {
            debugPrint(error)
        }
    }
    
    func unfavourite(_ movie: CKRecord, completed: @escaping (Result<CKRecord, Error>) -> Void) {
        movie.setValue(false, forKey: "favourite")
        
                
        database.save(movie) { (record, error) in
            if let error = error {
                completed(.failure(error))
                return
            }
            
            guard let record = record else {
                completed(.failure(CKError.unrecognized))
                return
            }
            
            completed(.success(record))
        }
    }
    
    func allfavourite(completed: @escaping (Result<[Movie], Error>) -> Void) {
        let query = CKQuery(recordType: "Movies", predicate: NSPredicate(value: true))
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else { return }
            let movies = records.serializeMovies()
            completed(.success(movies))
        }
    }
}

