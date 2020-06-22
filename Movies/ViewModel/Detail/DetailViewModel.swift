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

    private func download() {
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

    public func configure(detailView: DetailViewController) {
        DispatchQueue.main.async {
            detailView.nameLabel.text = self.movie.title
            detailView.ratingLabel.text = "\(self.movie.voteAverage ?? 0.0)"
            detailView.plotDescription.text = self.movie.overview
            detailView.productionCompaniesLabel.text = self.movie.productionCompaniesString()
            detailView.genreLabel.text = self.movie.genre()
            detailView.animationView.isHidden = false
            detailView.animationView.play()
            
            if self.movie.credits != nil {
                detailView.collectionView.isHidden = false
                detailView.castAndCrewLabel.isHidden = false
                detailView.collectionView.delegate = self
                detailView.collectionView.dataSource = self
                detailView.collectionView.showsHorizontalScrollIndicator = false
                detailView.collectionView.showsVerticalScrollIndicator = false
                detailView.collectionView.backgroundColor = .clear
                
                detailView.collectionView.reloadData()
            }else {
                detailView.castAndCrewLabel.isHidden = true
                detailView.collectionHeight.constant = 20.0
            }
            
            if #available(iOS 13.0, *) {
                if API.movie.isFavourite(self.movie) {
                    detailView.likeImage.image = MovieViewModel.fullHeart
                }else {
                    detailView.likeImage.image = MovieViewModel.hearth
                }
            } else {
                detailView.likeImage.isHidden = true
            }
        }

        guard let url = movie.posterURL(size: .original) else {
            return
        }

        ImageHelper.setImageTo(detailView.posterImageView, with: url) {
            DispatchQueue.main.async {
                detailView.animationView.isHidden = true
            }
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

// MARK: - UICollectionViewDelegate
extension DetailViewModel: UICollectionViewDelegate {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

}

// MARK: - UICollectionViewDataSource
extension DetailViewModel: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.credits?.cast.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastAndCrewCollectionViewCell.identifier, for: indexPath) as? CastAndCrewCollectionViewCell else { return UICollectionViewCell() }
        
        guard let cast = movie.credits?.cast[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.cast = cast

        return cell
    }

}

// MARK: - UICollectionViewDelegate
extension DetailViewModel: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0.0, left: 40.0, bottom: 0.0, right: 40.0)
    }
}
