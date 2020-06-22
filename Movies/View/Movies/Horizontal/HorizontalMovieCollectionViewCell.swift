//
//  HorizontalMovieCollectionViewCell.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import UIKit
import Lottie
import ViewAnimator

// MARK: - HorizontalMovieCollectionViewCell
public class HorizontalMovieCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "horizontalMovie"
    static var nib: UINib! = {
        return "HorizontalMovie".loadNib()
    }()
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var animationView: AnimationView!
    
    private var viewModel: MovieViewModel!
    static let zoomOut = AnimationType.zoom(scale: 1.5)
    static let zoomIn = AnimationType.zoom(scale: 1.0)
    private let animations = [zoomOut, zoomIn]
    
    public var movie: Movie! {
        didSet {
            viewModel = MovieViewModel(movie: movie)
            viewModel.configure(cell: self)
        }
    }
    
    public override func awakeFromNib() {
        nameLabel.font = Raleway.regular.font(size: 16.0)
        descriptionLabel.font = Raleway.light.font(size: 15.0)
        ratingLabel.font = Raleway.bold.font(size: 12.0)
        
        animationView.animation = Animation.named("movie")
        animationView.loopMode = .loop
        
        if #available(iOS 13.0, *) {
            nameLabel.textColor = UIColor.label
            descriptionLabel.textColor = UIColor.systemGray
            ratingLabel.textColor = UIColor.systemGray
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(likeMovie))
            tap.cancelsTouchesInView = true

            likeView.addGestureRecognizer(tap)
        } else {
            nameLabel.textColor = UIColor.black
            descriptionLabel.textColor = UIColor.lightGray
            ratingLabel.textColor = UIColor.lightGray
        }
        
        likeView.roundTo(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], cornerRadius: 10.0)
        likeView.isUserInteractionEnabled = true
        
        mainView.layer.cornerRadius = 10.0
        posterView.layer.cornerRadius = 10.0

        ShadowHelper.setShadow(to: posterView)
        ShadowHelper.setShadow(to: mainView)
    }
    
    @available(iOS 13.0, *)
    @objc public func likeMovie() {
        UIView.animate(views: [self.likeImage], animations: self.animations)
        
        if viewModel.isLiked {
            viewModel.dislike(movie)
            likeImage.image = MovieViewModel.hearth
        }else {
            viewModel.like(movie)
            likeImage.image = MovieViewModel.fullHeart
        }
        
    }
    
    public override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
}
