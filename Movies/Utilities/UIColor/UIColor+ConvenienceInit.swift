//
//  UIColor+ConvenienceInit.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {

    /**
     Creates a color from an hex int.
     
     - parameter hexString: A hexa-decimal color number representation.
     */
    convenience init(hex: UInt32) {
        let mask = 0x000000FF

        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex) & mask

        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }

}
