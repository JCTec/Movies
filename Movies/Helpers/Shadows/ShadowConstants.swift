//
//  ShadowConstants.swift
//  Movies
//
//  Created by Juan Carlos Estevez on 21/06/20.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation
import UIKit

public class MoviesShadowConstants {
    private var shadowColorValue: UIColor = .darkGray
    private var opacityValue: Float = 0.6
    private var offsetValue: CGSize = CGSize(width: 0.0, height: 3.0)
    private var radiusValue: CGFloat = 5.0

    public static let shared: MoviesShadowConstants = MoviesShadowConstants()

    private init() {
        print("MoviesShadowConstants")
    }

    public var shadowColor: UIColor {
        get {
            return shadowColorValue
        }

        set {
            shadowColorValue = newValue
        }
    }

    public var opacity: Float {
        get {
            return opacityValue
        }

        set {
            opacityValue = newValue
        }
    }

    public var offset: CGSize {
        get {
            return offsetValue
        }

        set {
            offsetValue = newValue
        }
    }

    public var radius: CGFloat {
        get {
            return radiusValue
        }

        set {
            radiusValue = newValue
        }
    }
}
