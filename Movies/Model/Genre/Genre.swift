//
//  Genre.swift
//  Movies
//
//  Created by Juan Carlos on 22/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - Genre
public struct Genre: Codable {
    public let id: Int
    public let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    public init(id: Int, name: String?) {
        self.id = id
        self.name = name
    }
}

class GenreCache: Cacheable {
    public let id: Int

    public init(id: Int) {
        self.id = id
    }

    public func cacheKey() -> String {
        return "Cache-Genre:\("\(id)".SHA1())"
    }
}
