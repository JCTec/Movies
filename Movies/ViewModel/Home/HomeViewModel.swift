//
//  HomeViewModel.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - HomeViewModel
public class HomeViewModel: NSObject {
    // MARK: - Delegate
    public weak var delegate: ErrorHandler?
    public weak var sectionDelegate: SectionCollectionViewCellDelegate?

}

// MARK: - Output
extension HomeViewModel {
    
    public static let sections: [Section] = [
        Section(title: "Now Playing", subtitle: "Movies now playing in your local cinema.", type: .nowPlaying),
        Section(title: "Popular", subtitle: "The most popular movies around the world", type: .popular),
        Section(title: "Top Rated", subtitle: "The most top rated movies of all time.", type: .topRated),
        Section(title: "Upcoming", subtitle: "The next movies to be premiere.", type: .upcoming)
    ]
    
    public func configure(collectionView: UICollectionView, width: CGFloat) {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(SectionCollectionViewCell.nib, forCellWithReuseIdentifier: SectionCollectionViewCell.identifier)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: width, height: 300)
        }
    }

    public func configure(cell: SectionCollectionViewCell, section: Section) -> SectionCollectionViewCell {
        cell.section = section
        cell.titleLabel.text = section.title
        cell.subtitleLabel.text = section.subtitle

        return cell
    }

    public func search(_ page: Int = 1, query: String, completed: @escaping ([Movie]) -> Void) {
        API.lists.search(page, query: query) { (result) in
            switch result {
                case .success(let movies):
                    completed(movies)
                case .failure(let error):
                    debugPrint(error)
                    completed([Movie]())
                    self.delegate?.didFinishUpdatingWith(error)
            }
        }
    }

    public func ofType(_ page: Int = 1, _ type: MovieListIdentifier, completed: @escaping ([Movie]) -> Void) {
        API.lists.ofType(page: page, type) { (result) in
            switch result {
                case .success(let movies):
                    completed(movies)
                case .failure(let error):
                    debugPrint(error)
                    completed([Movie]())
                    self.delegate?.didFinishUpdatingWith(error)
            }
        }
    }

}

// MARK: - UICollectionViewDelegate
extension HomeViewModel: UICollectionViewDelegate {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

}

// MARK: - UICollectionViewDataSource
extension HomeViewModel: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeViewModel.sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier, for: indexPath) as? SectionCollectionViewCell else { return UICollectionViewCell() }

        cell.delegate = sectionDelegate

        return configure(cell: cell, section: HomeViewModel.sections[indexPath.row])
    }

}

// MARK: - UICollectionViewDelegate
extension HomeViewModel: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 70, left: 0, bottom: 20, right: 0)
    }
}
