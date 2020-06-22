//
//  FavouriteMovie.swift
//  Movies
//
//  Created by Juan Carlos on 20/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import CoreData

// MARK: - FavouriteMovie
public class FavouriteMovie: NSManagedObject {
    @NSManaged var movieID: Int64
    @NSManaged var favourite: Bool
    @NSManaged var data: String
}


// MARK: - getMoviesFetchRequest
extension FavouriteMovie {
    
    /**
        The Fetch Request for the favourite movie list.

        An example use of getMoviesFetchRequest:

            try context.fetch(FavouriteMovie.getMoviesFetchRequest())
    */
    static func getMoviesFetchRequest() -> NSFetchRequest<FavouriteMovie> {
        let request: NSFetchRequest<FavouriteMovie> = NSFetchRequest<FavouriteMovie>(entityName: "FavouriteMovie")
        
        request.sortDescriptors = [NSSortDescriptor(key: "movieID", ascending: true)]
        
        return request
    }
}
