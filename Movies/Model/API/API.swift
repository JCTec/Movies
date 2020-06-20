//
//  API.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation


class API {
    // MARK: - APISettings
    
    /**
        The singleton representing settings utilized in the API calls and API functions.

        An example use of settings:

            API.settings.apiKey
    */
    static let settings: APISettings = APISettings()
    
    // MARK: - MovieAPI
    
    /**
        The singleton representing individual movie API calls and API functions.

        An example use of settings:

            API.movie.find(id: 1234) {}
    */
    static let movie: MovieAPI = MovieAPI()
    
    // MARK: - MovieListAPI
    
    /**
        The singleton representing the list of movies this class contains API calls and API functions.

        An example use of settings:

            API.movie.search(query: "search query") {}
    */
    static let lists: MovieListAPI = MovieListAPI()
}
