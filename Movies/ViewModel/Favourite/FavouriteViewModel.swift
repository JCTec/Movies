//
//  FavouriteViewModel.swift
//  Movies
//
//  Created by Juan Carlos on 20/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - FavouriteViewModel
@available(iOS 13.0, *)
public class FavouriteViewModel: NSObject {
    // MARK: - Delegate
    public weak var delegate: ErrorHandler?
}

// MARK: - Output
@available(iOS 13.0, *)
extension FavouriteViewModel {
    
    public func getFavourites(completed: @escaping ([Movie]) -> Void) {
        API.movie.allfavourite { (result) in
            switch result {
                case .success(let movies):
                    completed(movies)
                case .failure(let error):
                    debugPrint(error)
                    self.delegate?.didFinishUpdatingWith(error)
            }
        }
    }
}
