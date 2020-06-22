//
//  API.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - API
class API {
    /**
        The singleton representing settings utilized in the API calls and API functions.

        An example use of settings:

            API.settings.apiKey
    */
    static let settings: APISettings = APISettings()
    
    /**
        The singleton representing individual movie API calls and API functions.

        An example use of movie:

            API.movie.find(id: 1234) {}
    */
    static let movie: MovieAPI = MovieAPI()
    
    /**
        The singleton representing the list of movies this class contains API calls and API functions.

        An example use of lists:

            API.movie.search(query: "search query") {}
    */
    static let lists: MovieListAPI = MovieListAPI()
    
    /**
        The singleton that contains API calls and API functions for the Genre model.

        An example use of genre:

            API.genre.find(id: 123) {}
    */
    static let genre: GenreAPI = GenreAPI()
}
