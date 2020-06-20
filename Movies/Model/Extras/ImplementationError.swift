//
//  ImplementationError.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

public enum ImplementationError: Error {
    case urlError
    case unrecognized
    case dataError

    public func description() -> String {
        switch self {
            case .urlError:
                return "URL Error"
            case .unrecognized:
                return "Unrecognized Error"
            case .dataError:
                return "Data Error"
        }
    }
}
