//
//  ListMovie.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - MovieResultData
public struct MovieResultData: Codable {
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
    public let dates: Dates?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
        case dates = "dates"
    }

    public init(page: Int, totalResults: Int, dates: Dates, totalPages: Int, results: [Movie]) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
        self.dates = dates
    }
}

// MARK: - Dates
public struct Dates: Codable {
    public let maximum: String
    public let minimum: String

    enum CodingKeys: String, CodingKey {
        case maximum = "maximum"
        case minimum = "minimum"
    }

    public init(maximum: String, minimum: String) {
        self.maximum = maximum
        self.minimum = minimum
    }
}
