//
//  VerticalMovieCollectionViewCell.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import UIKit
import Lottie
import ViewAnimator

// MARK: - VerticalMovieCollectionViewCell
public class VerticalMovieCollectionViewCell: UICollectionViewCell {
    static let zoomOut = AnimationType.zoom(scale: 1.5)
    static let zoomIn = AnimationType.zoom(scale: 1.0)
    static let identifier: String = "verticalMovie"
    static var nib: UINib! = {
        return "VerticalMovie".loadNib()
    }()
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingsLabel: UILabel!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    
    public var viewModel: MovieViewModel!
    private let animations = [zoomOut, zoomIn]
    
    public var movie: Movie! {
        didSet {
            viewModel = MovieViewModel(movie: movie)
        }
    }
    
    public override func awakeFromNib() {
        animationView.animation = Animation.named("movie")
        animationView.loopMode = .loop
        
        mainView.layer.cornerRadius = 10.0
        moviePosterImageView.layer.cornerRadius = 10.0
        animationView.layer.cornerRadius = 10.0

        moviePosterImageView.clipsToBounds = true
        moviePosterImageView.contentMode = .scaleAspectFill
        
        likeView.roundTo(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], cornerRadius: 10.0)
        likeView.isUserInteractionEnabled = true
        
        if #available(iOS 13.0, *) {
            let tap = UITapGestureRecognizer(target: self, action: #selector(likeMovie))
            tap.cancelsTouchesInView = true

            likeView.addGestureRecognizer(tap)
        }
        
        movieTitleLabel.font = Raleway.regular.font(size: 15.0)
        movieRatingsLabel.font = Raleway.regular.font(size: 15.0)
        
        ShadowHelper.setShadow(to: moviePosterImageView)
        ShadowHelper.setShadow(to: mainView, multiplier: 0.6)
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
}
