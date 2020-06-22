//
//  Movie+Serializer.swift
//  Movies
//
//  Created by Juan Carlos on 20/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - [FavouriteMovie] Extension
extension Array where Element == FavouriteMovie {
    
    /**
        Transforms a FavouriteMovie array into a Movie Array by graving the data and utilizing a JSONSerializer.

        An example use of serializeMovies:

            records.serializeMovies() //[Movie]
    */
    func serializeMovies() -> [Movie] {
        var movies = [Movie]()
        
        for item in self {
            do {
                let data = Data(item.data.utf8)
                try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                movies.append(movie)
                
            } catch let error {
                debugPrint(error)
            }
        }
        
        return movies
    }
    
}
