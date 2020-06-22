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
    private let sections: [Section] = HomeViewModel.sections
    private var searchField: SearchField!
    private var searchValue: String!
    private var selectedValue: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        setUpSelfSizing()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Set Up
    func setUp() {
        searchField = SearchField(placeholderText: "Search movies")
        searchField.mainTextField().delegate = self

        view.addSubview(searchField)
        view.sendSubviewToBack(searchField)
        view.sendSubviewToBack(collectionView)
        
        viewModel.sectionDelegate = self
        viewModel.configure(collectionView: collectionView, width: view.frame.width)

        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 30.0),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            searchField.heightAnchor.constraint(equalToConstant: 55.0)
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
