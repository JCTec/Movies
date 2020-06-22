//
//  HomeViewController.swift
//  Movies
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import UIKit

// MARK: - HomeViewController
class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let searchSegue: String = "searchSegue"
    private let detailSegue: String = "detailSegue"
    
    private let viewModel: HomeViewModel = HomeViewModel()
    private var searchField: SearchField!
    private var searchValue: String!
    private var selectedValue: Movie!

    private var sections: [Section] = [
        Section(title: "Now Playing", subtitle: "Movies now playing in yyour local cinema.", type: .nowPlaying),
        Section(title: "Popular", subtitle: "The most popular movies arroud the world", type: .popular),
        Section(title: "Top Rated", subtitle: "The most top rated movies of all time.", type: .topRated),
        Section(title: "Upcoming", subtitle: "The next movies to be premiere.", type: .upcoming),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setUpSelfSizing()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Set Up
    func setUp() {
        searchField = SearchField(placeholderText: "Search movies")
        searchField.mainTextField().delegate = self
        
        view.addSubview(searchField)
        view.sendSubviewToBack(searchField)
        view.sendSubviewToBack(collectionView)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(SectionCollectionViewCell.nib, forCellWithReuseIdentifier: SectionCollectionViewCell.identifier)
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 30.0),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            searchField.heightAnchor.constraint(equalToConstant: 55.0),
        ])
    }
    
    private func setUpSelfSizing() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let w = collectionView.frame.width
            flowLayout.estimatedItemSize = CGSize(width: w, height: 300)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier?.equals(searchSegue) ?? false {
            SearchHelper.shared.searchParam = searchValue
            searchValue = ""
        }
        
        if segue.identifier?.equals(detailSegue) ?? false {
            if let vc = segue.destination as? DetailViewController {
                vc.movie = selectedValue
            }
        }
    }

}

// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchValue = textField.text
        
        searchField.didSelectClear()
        dismissKeyboard()
        
        if !searchValue.trim().isEmpty {
            searchSegue.performSegue(on: self)
        }
        
        return true
    }
}

// MARK: - SectionCollectionViewCellDelegate
extension HomeViewController: SectionCollectionViewCellDelegate {
    func didSelect(_ movie: Movie) {
        selectedValue = movie
        detailSegue.performSegue(on: self)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier, for: indexPath) as? SectionCollectionViewCell else { return UICollectionViewCell() }
        
        cell.delegate = self
        
        return viewModel.configure(cell: cell, section: sections[indexPath.row])
    }
    
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 70, left: 0, bottom: 20, right: 0)
    }
}
