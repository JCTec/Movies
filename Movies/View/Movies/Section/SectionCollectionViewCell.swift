//
//  SectionCollectionViewCell.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import UIKit
import ViewAnimator

// MARK: - SectionCollectionViewCellDelegate
public protocol SectionCollectionViewCellDelegate: class {
    func didSelect(_ movie: Movie)
}

// MARK: - SectionCollectionViewCell
public class SectionCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "sectionCell"
    static var nib: UINib! = {
        return "SectionCell".loadNib()
    }()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var supportingLine: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let animations = [AnimationType.from(direction: .right, offset: 30.0)]
    private var viewModel: SectionViewModel!
    private var movies: [Movie] = [Movie]()
    
    public weak var delegate: SectionCollectionViewCellDelegate?
    
    public var section: Section! {
        didSet {
            viewModel = SectionViewModel(section: section, delegate: self)
        }
    }
    
    public override func awakeFromNib() {
        supportingLine.layer.cornerRadius = 1.0
        supportingLine.backgroundColor = MovieStaticColors.yellow
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(VerticalMovieCollectionViewCell.nib, forCellWithReuseIdentifier: VerticalMovieCollectionViewCell.identifier)
        
        titleLabel.font = Raleway.bold.font(size: 20.0)
        subtitleLabel.font = Raleway.regular.font(size: 15.0)
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

// MARK: - DownloadFirstPageHandler
extension SectionCollectionViewCell: DownloadFirstPageHandler {
    public func didStartDownloadingFirstPage() {
        activityIndicator.startAnimating()
    }
    
    public func didFinishDownloadingFirstPage(movies: [Movie]) {
        
        DispatchQueue.main.async {
            self.movies = movies
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
            self.collectionView.performBatchUpdates({
                UIView.animate(views: self.collectionView.orderedVisibleCells,
                               animations: self.animations, animationInterval: 0.065, completion: nil)
            }, completion: nil)
        }
    }
    
    public func didFinishUpdatingWith(_ error: Error) {
        debugPrint(error)
    }
}

// MARK: - UICollectionViewDelegate
extension SectionCollectionViewCell: UICollectionViewDelegate {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

// MARK: - UICollectionViewDataSource
extension SectionCollectionViewCell: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(movies[indexPath.row])
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalMovieCollectionViewCell.identifier, for: indexPath) as? VerticalMovieCollectionViewCell else { return UICollectionViewCell() }
        
        return viewModel.configure(cell: cell, with: movies[indexPath.row])
    }
    
}

// MARK: - UICollectionViewDelegate
extension SectionCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170.0, height: 300.0)
    }
    
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
