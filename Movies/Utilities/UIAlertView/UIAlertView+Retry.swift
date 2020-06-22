//
//  UIAlertView+Retry.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import UIKit

public extension UIAlertController {
    
    static func retry(_ on: UIViewController, handler: @escaping () -> Void, cancel: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Something went wrong", message: "Do you want to try again?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action) in
            switch action.style {
                case .default:
                    print("default")
                case .cancel:
                    print("cancel")
                    if cancel != nil {
                        cancel!()
                    }

                case .destructive:
                    print("destructive")
                
                @unknown default:
                    print("Default")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch action.style {
                case .default:
                    print("default")
                    handler()
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                
                @unknown default:
                    print("Default")
            }
            
        }))
        
        on.present(alert, animated: true, completion: nil)
    }
    
    static func success(_ on: UIViewController, whith message: String, and title: String, handler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style {
                case .default:
                    print("default")
                    handler()
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                
                @unknown default:
                    print("Default")
            }
            
        }))
        
        on.present(alert, animated: true, completion: nil)
    }
}
