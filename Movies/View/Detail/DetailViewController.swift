//
//  DetailViewController.swift
//  Movies
//
//  Created by Juan Carlos on 22/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import UIKit
import Lottie
import SkeletonView
import ViewAnimator

// MARK: - DetailViewController
class DetailViewController: UIViewController {
    static let zoomOut = AnimationType.zoom(scale: 1.5)
    static let zoomIn = AnimationType.zoom(scale: 1.0)
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var plotDescription: UILabel!
    @IBOutlet weak var animationView: AnimationView!
    
    private var viewModel: DetailViewModel?
    private let animations = [zoomOut, zoomIn]

    public var movie: Movie! {
        didSet {
            viewModel = DetailViewModel(movie: movie, delegate: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let gradient = SkeletonGradient(baseColor: .clouds)

        nameLabel.showAnimatedGradientSkeleton(usingGradient: gradient)
        plotLabel.showAnimatedGradientSkeleton(usingGradient: gradient)
        genreLabel.showAnimatedGradientSkeleton(usingGradient: gradient)
        plotDescription.showAnimatedGradientSkeleton(usingGradient: gradient)
        animationView.play()
    }
    
    // MARK: - Set Up
    func setUp() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        if #available(iOS 13.0, *) {
            let tap = UITapGestureRecognizer(target: self, action: #selector(likeMovie))
            tap.cancelsTouchesInView = true

            likeImage.isUserInteractionEnabled = true
            likeImage.addGestureRecognizer(tap)
        }
        
        animationView.animation = Animation.named("movie")
        animationView.loopMode = .loop
        
        posterImageView.roundTo(corners: [.layerMinXMaxYCorner], cornerRadius: 25.0)
        animationView.roundTo(corners: [.layerMinXMaxYCorner], cornerRadius: 25.0)
    }
    
    @available(iOS 13.0, *)
    @objc public func likeMovie() {
        UIView.animate(views: [self.likeImage], animations: self.animations)
        
        if viewModel?.isLiked ?? false {
            viewModel?.dislike(movie)
            likeImage.image = MovieViewModel.hearth
        }else {
            viewModel?.like(movie)
            likeImage.image = MovieViewModel.fullHeart
        }
        
    }

    @IBAction func didSelectDismis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func handleRetry() {
        UIAlertController.retry(self, handler: { () in
            self.viewModel = DetailViewModel(movie: self.movie, delegate: self)
        }, cancel: { ()
            self.dismiss(animated: true, completion: nil)
        })
    }
}

extension DetailViewController: DownloadFirstPageHandler {
    func didStartDownloadingFirstPage() {
        print("didStartDownloadingFirstPage")
    }
    
    func didFinishDownloadingFirstPage(movies: [Movie]) {        
        DispatchQueue.main.async {
            self.viewModel?.configure(detailView: self)
            
            self.nameLabel.hideSkeleton()
            self.plotLabel.hideSkeleton()
            self.genreLabel.hideSkeleton()
            self.plotDescription.hideSkeleton()
        }
    }
    
    func didFinishUpdatingWith(_ error: Error) {
        debugPrint(error)
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
