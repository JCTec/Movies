//
//  Movie.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - Movie
public struct Movie: Codable {
    public let id: Int
    public let adult: Bool?
    public let backdropPath: String?
    public let belongsToCollection: BelongsToCollection?
    public let budget: Int?
    public let genreIDs: [Int]?
    public var genres: [Genre]?
    public let homepage: String?
    public let imdbID: String?
    public let originalLanguage: String?
    public let originalTitle: String?
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let productionCompanies: [ProductionCompany]?
    public let productionCountries: [ProductionCountry]?
    public let releaseDate: String?
    public let revenue: Int?
    public let runtime: Int?
    public let spokenLanguages: [SpokenLanguage]?
    public let status: String?
    public let tagline: String?
    public let title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget = "budget"
        case genreIDs = "genre_ids"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case spokenLanguages = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    public func posterURL(size: PosterSize) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/\(size.rawValue)\(posterPath ?? "")\(API.settings.apiKey)")
    }
    
    public func genre() -> String {
        return (genres?.map { $0.name ?? "" } ?? [String]()).joined(separator: " | ")
    }
    
    public func productionCompaniesString() -> String {
        return (productionCompanies?.map { $0.name ?? "" } ?? [String]()).joined(separator: " | ")
    }

    public init(id: Int, adult: Bool?, backdropPath: String?, belongsToCollection: BelongsToCollection?, budget: Int?, genreIDs: [Int]?, genres: [Genre]?, homepage: String?, imdbID: String?, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double?, posterPath: String?, productionCompanies: [ProductionCompany]?, productionCountries: [ProductionCountry]?, releaseDate: String?, revenue: Int?, runtime: Int?, spokenLanguages: [SpokenLanguage]?, status: String?, tagline: String?, title: String?, video: Bool?, voteAverage: Double?, voteCount: Int?) {
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genreIDs = genreIDs
        self.genres = genres
        self.homepage = homepage
        self.imdbID = imdbID
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

class MovieCache: Cacheable {
    let id: Int!
    
    public init(id: Int) {
        self.id = id
    }
    
    public func cacheKey() -> String {
        return "Cache-Movie:\("\(id ?? 0)".SHA1())"
    }
    
}

// MARK: - BelongsToCollection
public struct BelongsToCollection: Codable {
    public let id: Int
    public let name: String?
    public let posterPath: String?
    public let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }

    public init(id: Int, name: String?, posterPath: String?, backdropPath: String?) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
}

// MARK: - ProductionCompany
public struct ProductionCompany: Codable {
    public let id: Int
    public let logoPath: String?
    public let name: String?
    public let originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case logoPath = "logo_path"
        case name = "name"
        case originCountry = "origin_country"
    }

    public init(id: Int, logoPath: String?, name: String?, originCountry: String?) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
}

// MARK: - ProductionCountry
public struct ProductionCountry: Codable {
    public let iso639N1: String?
    public let name: String?

    enum CodingKeys: String, CodingKey {
        case iso639N1 = "iso_3166_1"
        case name = "name"
    }

    public init(iso639N1: String?, name: String?) {
        self.iso639N1 = iso639N1
        self.name = name
    }
}

// MARK: - SpokenLanguage
public struct SpokenLanguage: Codable {
    public let iso639N1: String?
    public let name: String?

    enum CodingKeys: String, CodingKey {
        case iso639N1 = "iso_639_1"
        case name = "name"
    }

    public init(iso639N1: String?, name: String?) {
        self.iso639N1 = iso639N1
        self.name = name
    }
}
