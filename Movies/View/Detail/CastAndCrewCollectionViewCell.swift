//
//  CastAndCrewCollectionViewCell.swift
//  Movies
//
//  Created by Juan Carlos on 22/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import UIKit

class CastAndCrewCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "castAndCrewCell"
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    public var cast: Cast! {
        didSet {
            guard let url = cast.posterURL(size: .w400) else {
                return
            }

            ImageHelper.setImageTo(mainImageView, with: url) {
                debugPrint("Image Set")
            }
        }
    }
    
    override func awakeFromNib() {
        mainImageView.layer.cornerRadius = 45.0
    }
}
