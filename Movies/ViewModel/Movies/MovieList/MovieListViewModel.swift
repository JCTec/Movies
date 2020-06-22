//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import UIKit

// MARK: - InteractiveDownloadHandler
public protocol InteractiveDownloadHandler: ErrorHandler {
    func nextPage(completed: @escaping ([Movie]) -> Void, error: @escaping (Error) -> Void)
    func didSelect(movie: Movie)
}

// MARK: - MovieListViewModel
public class MovieListViewModel: NSObject {
    public static let collectionViewTag: Int = 97

    public weak var delegate: InteractiveDownloadHandler?
    public weak var collectionView: UICollectionView!
    
    private var movies: [Movie] = [Movie]()
    
    public init(movies: [Movie]) {
        self.movies = movies
    }
    
    public func getCollectionView(width: CGFloat) -> UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.tag = MovieListViewModel.collectionViewTag
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(HorizontalMovieCollectionViewCell.nib, forCellWithReuseIdentifier: HorizontalMovieCollectionViewCell.identifier)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: width, height: 250.0)
        }
        
        collectionView.addInfiniteScroll { (collectionView) in
            if let delegate = self.delegate {
                delegate.nextPage(completed: { (movies) in
                    DispatchQueue.main.async {
                        self.movies += movies
                        self.collectionView.reloadData()
                        collectionView.finishInfiniteScroll()
                    }
                }, error: { (error) in
                    debugPrint(error)
                    collectionView.finishInfiniteScroll()
                })
            }else {
                collectionView.finishInfiniteScroll()
            }
        }
        
        self.collectionView = collectionView
        return collectionView
    }

}

// MARK: - UICollectionViewDelegate
extension MovieListViewModel: UICollectionViewDelegate {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

// MARK: - UICollectionViewDataSource
extension MovieListViewModel: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(movie: movies[indexPath.row])
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalMovieCollectionViewCell.identifier, for: indexPath) as? HorizontalMovieCollectionViewCell else { return UICollectionViewCell() }
        
        cell.movie = movies[indexPath.row]
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension MovieListViewModel: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}
