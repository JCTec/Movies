//
//  SearchViewModel.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - SearchViewModel
public class SearchViewModel: NSObject {
    // MARK: - Delegate
    public weak var delegate: DownloadFirstPageHandler?

    // MARK: - Private Lets
    private let searchParam: String!
    private var page: Int = 1
    private var response: [Movie]!

    public override init() {
        self.searchParam = SearchHelper.shared.searchParam

        super.init()
        self.search()
    }

    private func search() {
        delegate?.didStartDownloadingFirstPage()
        page = 1

        DispatchQueue.main.async {
            API.lists.search(self.page, query: self.searchParam) { (result) in
                switch result {
                    case .success(let movies):
                        self.delegate?.didFinishDownloadingFirstPage(movies: movies)
                        self.page += 1

                    case .failure(let error):
                        debugPrint(error)
                        self.delegate?.didFinishUpdatingWith(error)
                }
            }
        }
    }
}

// MARK: - Output
extension SearchViewModel {

    public var resultTitle: String {
        get {
            "Results for \"\(SearchHelper.shared.searchParam)\""
        }
    }

    public func nextPage(completed: @escaping ([Movie]) -> Void, error: @escaping (Error) -> Void) {
        API.lists.search(page, query: searchParam) { (result) in
            switch result {
                case .success(let movies):
                    debugPrint(movies)
                    self.page += 1
                    completed(movies)

                case .failure(let err):
                    debugPrint(err)
                    error(err)
            }
        }
    }

}
