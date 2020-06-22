//
//  Cache.swift
//  Movies
//
//  Created by Juan Carlos on 22/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

public class Cache {
    public var storage = FileStorage()

    public func load<A: Codable>(_ resource: Cacheable) -> A? {
        if let data = storage[resource.cacheKey()] {
            do {
                try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let response = try JSONDecoder().decode(A.self, from: data)

                return response
            } catch _ {
                return nil
            }
        }else {
            return nil
        }
    }

    public func save(_ resource: Cacheable, data: Data) {
        storage[resource.cacheKey()] = data
    }
}
