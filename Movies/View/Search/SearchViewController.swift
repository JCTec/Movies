//
//  SearchViewController.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import UIKit

// MARK: - SearchViewController
class SearchViewController: UIViewController {
    private let detailSegue: String = "detailSegue"
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: SearchViewModel?
    private var movieListViewModel: MovieListViewModel?
    private var selectedMovie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    // MARK: - Set Up
    func setUp() {
        hideNavigationBar()
        
        viewModel = SearchViewModel()
        viewModel?.delegate = self

        resultTitleLabel.text = viewModel?.resultTitle
    }
    
    private func handleRetry() {
        UIAlertController.retry(self, handler: { () in
            self.viewModel = nil
            self.activityIndicator.isHidden = false
            
            if let view = self.view.viewWithTag(MovieListViewModel.collectionViewTag) {
                view.removeFromSuperview()
            }
            
            self.movieListViewModel = nil
            
            self.viewModel = SearchViewModel()
            self.viewModel?.delegate = self
        }, cancel: { ()
            self.viewModel = nil
            self.movieListViewModel = nil
            self.activityIndicator.isHidden = true
            
            self.resultsLabel.text = "0 Results"
            
            if let view = self.view.viewWithTag(MovieListViewModel.collectionViewTag) {
                view.removeFromSuperview()
            }
        })
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

extension SearchViewController: DownloadFirstPageHandler {
    func didStartDownloadingFirstPage() {
        if !activityIndicator.isHidden {
            activityIndicator.startAnimating()
        }
    }
    
    func didFinishDownloadingFirstPage(movies: [Movie]) {
        DispatchQueue.main.async {
            self.movieListViewModel = MovieListViewModel(movies: movies)
            self.movieListViewModel?.delegate = self
            
            self.activityIndicator.isHidden = true
            
            guard let collectionView = self.movieListViewModel?.getCollectionView(width: self.view.frame.width) else {
                return
            }
            
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
    
    func didFinishUpdatingWith(_ error: Error) {
        handleRetry()
    }
}

extension SearchViewController: InteractiveDownloadHandler {
    func didSelect(movie: Movie) {
        selectedMovie = movie
        detailSegue.performSegue(on: self)
    }
    
    func nextPage(completed: @escaping ([Movie]) -> Void, error: @escaping (Error) -> Void) {
        viewModel?.nextPage(completed: { (movies) in
            completed(movies)
        }, error: { (er) in
            error(er)
        })
    }
}
