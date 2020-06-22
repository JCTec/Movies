//
//  MovieCache.swift
//  Movies
//
//  Created by Juan Carlos on 22/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - MovieCache
class MovieCache: Cacheable {
    let id: Int!

    public init(id: Int) {
        self.id = id
    }

    public func cacheKey() -> String {
        return "Cache-Movie:\("\(id ?? 0)".SHA1())"
    }

}
