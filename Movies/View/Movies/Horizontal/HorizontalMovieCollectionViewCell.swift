//
//  HorizontalMovieCollectionViewCell.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import UIKit

public class HorizontalMovieCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "horizontalMovie"
    static var nib: UINib! = {
        return "HorizontalMovie".loadNib()
    }()
    
}
