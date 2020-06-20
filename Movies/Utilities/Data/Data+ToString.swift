//
//  Data+ToString.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

public extension Data {
    
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
    
}
