//
//  FavouriteViewController.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import UIKit

// MARK: - FavouriteViewController
@available(iOS 13.0, *)
class FavouriteViewController: UIViewController {
    private let detailSegue: String = "detailSegue"
    
    private let viewModel: FavouriteViewModel = FavouriteViewModel()
    private var movieListViewModel: MovieListViewModel?
    private var selectedMovie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        load()
    }
    
    @objc private func load() {
        viewModel.getFavourites { (movies) in
            self.movieListViewModel = MovieListViewModel(movies: movies)
            self.movieListViewModel?.delegate = self
            
            guard let collectionView = self.movieListViewModel?.getCollectionView(width: self.view.frame.width) else {
                return
            }
            
            if let view = self.view.viewWithTag(MovieListViewModel.collectionViewTag) {
                view.removeFromSuperview()
            }
            
            collectionView.refreshControl = self.refreshController()
            
            self.view.addSubview(collectionView)
            self.view.bringSubviewToFront(collectionView)
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100.0),
                collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0),
                collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0),
                collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0),
            ])
        }
    }
    
    private func refreshController() -> UIRefreshControl {
        let refreshControlV = UIRefreshControl()
        
        refreshControlV.addTarget(self, action: #selector(load), for: .valueChanged)
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: Raleway.regular.font(size: 22),
            .foregroundColor: UIColor.label
        ]
        
        refreshControlV.tintColor = UIColor.label
        refreshControlV.attributedTitle = NSAttributedString(string: "Loading...", attributes: textAttributes)
        
        return refreshControlV
    }
 
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier?.equals(detailSegue) ?? false {
            if let vc = segue.destination as? DetailViewController {
                vc.movie = selectedMovie
            }
        }
    }

}

@available(iOS 13.0, *)
extension FavouriteViewController: InteractiveDownloadHandler {
    func nextPage(completed: @escaping ([Movie]) -> Void, error: @escaping (Error) -> Void) {
        completed([Movie]())
    }
    
    func didSelect(movie: Movie) {
        selectedMovie = movie
        detailSegue.performSegue(on: self)
    }
    
    func didFinishUpdatingWith(_ error: Error) {
        debugPrint(error)
    }
}
