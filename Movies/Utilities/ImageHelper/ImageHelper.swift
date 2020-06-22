//
//  ImageHelper.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

class ImageHelper {
    static let brokenImage: UIImage = #imageLiteral(resourceName: "broken")
    
    static func setImageTo(_ imageView: UIImageView, with url: URL, completion: @escaping () -> Void) {

        imageView.sd_setImage(with: url, placeholderImage: UIImage(), options: .highPriority) { (image, error, _, url) in
            
            if error == nil {
                imageView.image = image
                
                imageView.clipsToBounds = true
                imageView.contentMode = .scaleAspectFill
            }else {
                debugPrint(error ?? "No Error in Image from URL: \(url!)")

                imageView.image = ImageHelper.brokenImage
                
                imageView.clipsToBounds = true
                imageView.contentMode = .scaleAspectFit
            }
            
            completion()
        }
        
    }
    
}
