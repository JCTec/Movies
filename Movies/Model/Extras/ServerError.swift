//
//  ServerError.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

public enum ServerError: Error {
    case notFound
    case badRequest
    case unauthorized
    case unrecognized

    public func description() -> String {
        switch self {
            case .notFound:
                return "Not Found"
            case .badRequest:
                return "Bad Request"
            case .unauthorized:
                return "Unauthorized"
            case .unrecognized:
                return "Unrecognized"
        }
    }
}
