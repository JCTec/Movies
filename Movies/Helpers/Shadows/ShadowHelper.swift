//
//  ShadowHelper.swift
//  Movies
//
//  Created by Juan Carlos Estevez on 21/06/20.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation
import UIKit

public class ShadowHelper {
    public static func setShadow(to view: UIView, multiplier: Double = 1.0) {
        view.setShadow(with: MoviesShadowConstants.shared.shadowColor, opacity: MoviesShadowConstants.shared.opacity * Float(multiplier), offset: MoviesShadowConstants.shared.offset, radius: MoviesShadowConstants.shared.radius * CGFloat(multiplier), viewCornerRadius: 0.0)
    }

    public static func removeShadow(to view: UIView) {
        view.removeShadow()
    }

    public static func setObscureShadow(to view: UIView, multiplier: Double = 1.0, viewCornerRadius: CGFloat = 0.0) {
        view.setShadow(with: MovieStaticColors.darkShadow, opacity: MoviesShadowConstants.shared.opacity * Float(multiplier), offset: MoviesShadowConstants.shared.offset, radius: MoviesShadowConstants.shared.radius * CGFloat(multiplier), viewCornerRadius: viewCornerRadius)
    }

    public static func setRightShadow(to view: UIView, multiplier: Double = 1.0) {
        view.setShadow(with: MoviesShadowConstants.shared.shadowColor, opacity: MoviesShadowConstants.shared.opacity * Float(multiplier), offset: CGSize(width: 10.0, height: 3.0), radius: MoviesShadowConstants.shared.radius * CGFloat(multiplier), viewCornerRadius: 0.0)
    }

    public static func setTopShadow(to view: UIView, multiplier: Double = 1.0) {
        view.setShadow(with: MoviesShadowConstants.shared.shadowColor, opacity: 0.9 * Float(multiplier), offset: CGSize(width: 0.0, height: -5.0), radius: 35.0, viewCornerRadius: 0.0)
    }

    public static func setShadowTo(navBar: UIView) {
        navBar.setShadow(with: MoviesShadowConstants.shared.shadowColor, opacity: 0.7, offset: CGSize(width: 0.0, height: 4.0), radius: 5.0, viewCornerRadius: 0.0)
    }

    public static func setShadowTo(view: UIView) {
        view.setShadow(with: MoviesShadowConstants.shared.shadowColor, opacity: MoviesShadowConstants.shared.opacity, offset: CGSize(width: -2.0, height: 0.0), radius: MoviesShadowConstants.shared.radius, viewCornerRadius: 0.0)
    }
}
