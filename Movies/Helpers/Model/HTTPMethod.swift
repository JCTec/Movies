//
//  HTTPMethod.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - HTTPMethod
enum HTTPMethod {
    case get, head, post, put, delete, connect, options, trace, patch
    
    func toString() -> String {
        switch self {
            case .get:
                return "GET"
            case .head:
                return "HEAD"
            case .post:
                return "POST"
            case .put:
                return "PUT"
            case .delete:
                return "DELETE"
            case .connect:
                return "CONNECT"
            case .options:
                return "OPTIONS"
            case .trace:
                return "TRACE"
            case .patch:
                return "PATCH"
        }
    }
}
