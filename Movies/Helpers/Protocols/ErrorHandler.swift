//
//  ErrorHandler.swift
//  Movies
//
//  Created by Juan Carlos on 20/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

public protocol ErrorHandler: class {
    func didFinishUpdatingWith(_ error: Error)
}
