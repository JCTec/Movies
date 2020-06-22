//
//  MovieViewModel.swift
//  Movies
//
//  Created by Juan Carlos on 22/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - MovieViewModel
public class MovieViewModel: NSObject {
    public weak var delegate: ErrorHandler?
    
    public let fullHeart: UIImage = #imageLiteral(resourceName: "heartFull")
    public let hearth: UIImage = #imageLiteral(resourceName: "heart")
    
    private var movie: Movie!

    public init(movie: Movie) {
        super.init()
        self.movie = movie
    
    }

}

// MARK: - Output
extension MovieViewModel {
    
    public func configure(cell: HorizontalMovieCollectionViewCell) {
        cell.nameLabel.text = movie.title
        cell.descriptionLabel.text = "Loading..."
        cell.ratingLabel.text = "\(movie.voteAverage ?? 0.0)"
        
        cell.animationView.isHidden = false
        cell.animationView.play()
        
        if #available(iOS 13.0, *) {
            if API.movie.isFavourite(movie) {
                cell.likeImage.image = fullHeart
            }else {
                cell.likeImage.image = hearth
            }
        } else {
            cell.likeView.isHidden = true
        }
        
        API.genre.setGenreFromIds(movie) { (movie) in
            cell.descriptionLabel.text = movie.genre()
        }

        guard let url = movie.posterURL(size: .original) else {
            return
        }
        
        ImageHelper.setImageTo(cell.posterView, with: url) {
            cell.animationView.isHidden = true
        }
    }
    
    @available(iOS 13.0, *)
    public var isLiked: Bool {
        get {
            return API.movie.isFavourite(movie)
        }
        
        set {
            fatalError("isLiked is a get-only property")
        }
    }
    
    @available(iOS 13.0, *)
    public func like(_ movie: Movie) {
        API.movie.favourite(movie) { (result) in
            switch result {
                case .success(let fav):
                    debugPrint(fav)
            case .failure(let error):
                    debugPrint(error)
                    self.delegate?.didFinishUpdatingWith(error)
            }
        }
    }

    @available(iOS 13.0, *)
    public func dislike(_ movie: Movie) {
        if let fav = API.movie.get(movie) {
            API.movie.unfavourite(fav) { (result) in
                switch result {
                    case .success(let fav):
                        debugPrint(fav)
                case .failure(let error):
                        debugPrint(error)
                        self.delegate?.didFinishUpdatingWith(error)
                }
            }
        }
    }

}
