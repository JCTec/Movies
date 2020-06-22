//
//  APISettings.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

class APISettings {
    /**
        The Movie Database Key  Variable of String type with its complement var name, to be add in a URL

        An example use of APY Key:

            return "?api_key=\(apiKeyStr)"
    */
    private var apiKeyStr: String = ""

    /**
        The Movie Database Key with its complement var name, to be add in a URL

        An example use of APY Key:

            let url = "https://api.themoviedb.org/3/movie/\(id)\(API.settings.apiKey())"
    */
    public var apiKey: String {
        get {
            return "?api_key=\(apiKeyStr)"
        }

        set {
            apiKeyStr = newValue
        }
    }

    /**
        The API cache with filestorage implementation.

        An example use of APY Key:

            API.settings.cache.load(obj)
    */
    public let cache = Cache()
    
    /**
        This key appends to the movie database response the credits of the film.

        An example use of Credits Key:

            let url = "https://api.themoviedb.org/3/movie/\(id)\(API.settings.apiKey())\(API.settings.creditsKey)"
    */
    public var creditsKey: String {
        get {
            return "&append_to_response=credits"
        }
    }
}
