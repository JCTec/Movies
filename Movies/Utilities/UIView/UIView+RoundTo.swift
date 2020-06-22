//
//  UIView+RoundTo.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {

    /// Set rounded corners to button.
    ///
    /// - Parameters:
    ///   - crn: Corners to add rounded.
    ///   - cornerRadius: Size of corner radius.
    @available(iOS 11.0, *)
    func roundTo(corners crn: CACornerMask, cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.maskedCorners = crn
    }
}
