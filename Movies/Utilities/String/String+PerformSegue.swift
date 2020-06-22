//
//  String+PerformSegue.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    /// This function lets you easily perform a segue in a given UIViewController
    ///
    /// Usage:
    ///
    ///     "SegueName".performSegue(on: self)
    ///
    /// - Parameter view: The ViewController to perform the segue on.
    func performSegue(on view: UIViewController) {
        #if DEBUG
            if view.canPerformSegue(withIdentifier: self) {
                DispatchQueue.main.async {
                    view.performSegue(withIdentifier: self, sender: nil)
                }
            }
        #else
            DispatchQueue.main.async {
                view.performSegue(withIdentifier: self, sender: nil)
            }
        #endif
        

    }
    
}
