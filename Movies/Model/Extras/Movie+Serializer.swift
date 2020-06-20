//
//  Movie+Serializer.swift
//  Movies
//
//  Created by Juan Carlos on 20/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import CloudKit

extension Array where Element == CKRecord {
    
    func serializeMovies() -> [Movie] {
        var movies = [Movie]()

        for item in self {
            do {
                if let dataString = item["data"] as? String {
                    let data = Data(dataString.utf8)
                    try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    movies.append(movie)
                }
            } catch let error {
                debugPrint(error)
            }
        }
        
        return movies
    }
    
}
