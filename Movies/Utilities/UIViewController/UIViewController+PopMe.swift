//
//  UIViewController+PopMe.swift
//  Movies
//
//  Created by Juan Carlos on 22/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    func popViewController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
}
