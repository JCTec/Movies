//
//  DetailViewModel.swift
//  Movies
//
//  Created by Juan Carlos on 20/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - DetailViewModel
public class DetailViewModel: NSObject {
    // MARK: - Delegate
    public weak var delegate: DownloadFirstPageHandler?
    
    // MARK: - Private Lets
    private var movie: Movie!
    
    public init(movie: Movie, delegate: DownloadFirstPageHandler? = nil) {
        super.init()
        self.delegate = delegate
        self.movie = movie
        download()
    }
    
    func download() {
        delegate?.didStartDownloadingFirstPage()
        
        API.movie.find(id: movie.id) { (result) in
            switch result {
                case .success(let movie):
                    self.movie = movie
                    self.delegate?.didFinishDownloadingFirstPage(movies: [movie])
                case .failure(let error):
                    self.delegate?.didFinishUpdatingWith(error)
            }
        }
    }
}

// MARK: - Output
extension DetailViewModel {
    
    func configure(detailView: DetailViewController) {
        detailView.nameLabel.text = movie.title
        detailView.ratingLabel.text = "\(movie.voteAverage ?? 0.0)"
        detailView.plotDescription.text = movie.overview
        detailView.genreLabel.text = movie.genre()
        
        detailView.animationView.isHidden = false
        detailView.animationView.play()
        
        if #available(iOS 13.0, *) {
            if API.movie.isFavourite(movie) {
                detailView.likeImage.image = MovieViewModel.fullHeart
            }else {
                detailView.likeImage.image = MovieViewModel.hearth
            }
        } else {
            detailView.likeImage.isHidden = true
        }

        guard let url = movie.posterURL(size: .original) else {
            return
        }
        
        ImageHelper.setImageTo(detailView.posterImageView, with: url) {
            detailView.animationView.isHidden = true
        }
    }
    
    public func configure(cell: VerticalMovieCollectionViewCell, with movie: Movie) -> VerticalMovieCollectionViewCell {
        cell.movieTitleLabel.text = movie.title
        cell.movieRatingsLabel.text = "\(movie.voteAverage ?? 0.0)"
        cell.animationView.isHidden = false
        cell.animationView.play()
        cell.movie = movie
        
        if #available(iOS 13.0, *) {
            if API.movie.isFavourite(movie) {
                cell.likeImage.image = MovieViewModel.fullHeart
            }else {
                cell.likeImage.image = MovieViewModel.hearth
            }
        } else {
            cell.likeView.isHidden = true
        }

        guard let url = movie.posterURL(size: .original) else {
            return cell
        }
        
        ImageHelper.setImageTo(cell.moviePosterImageView, with: url) {
            cell.animationView.isHidden = true
        }
        
        return cell
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
