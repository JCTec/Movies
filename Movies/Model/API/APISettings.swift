//
//  APISettings.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

class APISettings {
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
}
