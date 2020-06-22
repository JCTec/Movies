//
//  FileStorage.swift
//  Movies
//
//  Created by Juan Carlos on 22/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

public struct FileStorage {
    public var baseURL: URL!
    
    public init() {
        baseURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }

    public subscript(key: String) -> Data? {
        get {
            let url = baseURL.appendingPathComponent(key)
            return try? Data(contentsOf: url)
        }
        set {
            let url = baseURL.appendingPathComponent(key)
            _ = try? newValue?.write(to: url)
        }
    }
}
