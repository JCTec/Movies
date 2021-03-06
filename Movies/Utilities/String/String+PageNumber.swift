//
//  String+PageNumber.swift
//  Movies
//
//  Created by Juan Carlos on 20/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

extension String {
    static func page(_ number: Int, divider: String = "&") -> String {
        return "\(divider)page=\(number)"
    }
}
