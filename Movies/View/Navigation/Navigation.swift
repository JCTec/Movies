//
//  Navigation.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import UIKit

// MARK: - NavigationController
class NavigationController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.tintColor = MovieStaticColors.yellow

        tabBar.items?[0].image = HomeViewController.tabImage
        tabBar.items?[0].selectedImage = HomeViewController.selectedImage

        if #available(iOS 13.0, *) {
            tabBar.items?[1].image = FavouriteViewController.tabImage
            tabBar.items?[1].selectedImage = FavouriteViewController.selectedImage
        }
    }
}

extension HomeViewController {
    static let tabImage = #imageLiteral(resourceName: "home.pdf").resized(width: 20.0, height: 20.0)
    static let selectedImage = #imageLiteral(resourceName: "browser").resized(width: 20.0, height: 20.0)
}

@available(iOS 13.0, *)
extension FavouriteViewController {
    static let tabImage = #imageLiteral(resourceName: "heartBlack").resized(width: 20.0, height: 20.0)
    static let selectedImage = #imageLiteral(resourceName: "heartFullBlack").resized(width: 20.0, height: 20.0)
}
