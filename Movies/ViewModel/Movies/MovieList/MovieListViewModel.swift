//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation



// MARK: - SectionViewModel
public class MovieListViewModel: NSObject {
    public weak var delegate: DownloadFirstPageHandler?
    
    private var section: Section!
    private var page: Int = 1
    
    public init(section: Section, delegate: SectionViewModelDelegate) {
        super.init()
        self.section = section
        self.delegate = delegate
        
        startDownload()
    }

    private func startDownload() {
        self.delegate?.didStartDownloadingFirstPage()

        DispatchQueue.main.async {
            self.nextPage { (movies) in
                self.delegate?.didFinishDownloadingFirstPage(movies: movies)
            }
        }
        
    }
}

// MARK: - Output
extension SectionViewModel {
    
    public func configure(cell: VerticalMovieCollectionViewCell, with movie: Movie) -> VerticalMovieCollectionViewCell {
        cell.movieTitleLabel.text = movie.title
        cell.movieRatingsLabel.text = "\(movie.voteAverage ?? 0.0)"
        cell.animationView.isHidden = false
        cell.animationView.play()

        guard let url = movie.posterURL(size: .original) else {
            return cell
        }
        
        ImageHelper.setImageTo(cell.moviePosterImageView, with: url) {
            cell.animationView.isHidden = true
        }
        
        return cell
    }
    
    public func nextPage(completed: @escaping ([Movie]) -> Void) {
        API.lists.ofType(page, type) { (result) in
            switch result {
                case .success(let movies):
                    self.page += 1
                    completed(movies)
                case .failure(let error):
                    debugPrint(error)
                    completed([Movie]())
                    self.delegate?.didFinishUpdatingWith(error)
            }
        }
    }
    
    public var title: String {
        get {
            return section.title
        }
        
        set {
            fatalError("Title is a get-only property")
        }
    }
    
    public var subtitle: String {
        get {
            return section.subtitle
        }
        
        set {
            fatalError("Subtitle is a get-only property")
        }
    }
    
    public var type: MovieListIdentifier {
        get {
            return section.type
        }
        
        set {
            fatalError("Type is a get-only property")
        }
    }

}
