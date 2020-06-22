//
//  Raleway.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import UIKit

public enum Raleway {
    case black
    case blackItalic
    case bold
    case boldItalic
    case extraBold
    case extraBoldItalic
    case extraLight
    case extraLightItalic
    case italic
    case light
    case lightItalic
    case medium
    case mediumItalic
    case regular
    case semiBold
    case semiBoldItalic
    case thin
    case thinItalic

    public func fontName() -> String {
        switch self {
            case .black:
                return "Raleway-Black"
            case .blackItalic:
                return "Raleway-BlackItalic"
            case .bold:
                return "Raleway-Bold"
            case .boldItalic:
                return "Raleway-BoldItalic"
            case .extraBold:
                return "Raleway-ExtraBold"
            case .extraBoldItalic:
                return "Raleway-ExtraBoldItalic"
            case .extraLight:
                return "Raleway-ExtraLight"
            case .extraLightItalic:
                return "Raleway-ExtraLightItalic"
            case .italic:
                return "Raleway-Italic"
            case .light:
                return "Raleway-Light"
            case .lightItalic:
                return "Raleway-LightItalic"
            case .medium:
                return "Raleway-Medium"
            case .mediumItalic:
                return "Raleway-MediumItalic"
            case .regular:
                return "Raleway-Regular"
            case .semiBold:
                return "Raleway-SemiBold"
            case .semiBoldItalic:
                return "Raleway-SemiBoldItalic"
            case .thin:
                return "Raleway-Thin"
            case .thinItalic:
                return "Raleway-ThinItalic"
        }
    }

    public func font(size: CGFloat) -> UIFont {
        let plus = CGFloat(UserDefaults.standard.float(forKey: "plusFontSize"))
        
        guard let fontToUse = UIFont(name: fontName(), size: size + plus) else { return UIFont.systemFont(ofSize: size) }
        
        return fontToUse
    }
}
