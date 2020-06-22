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
}

// MARK: - Output
extension HomeViewModel {
    
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
