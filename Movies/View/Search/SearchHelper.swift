//
//  SearchHelper.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

// MARK: - DownloadFirstPageHandler
class SearchHelper {

    static let shared: SearchHelper = SearchHelper()

    private var searchValue: String = "Search"

    public var searchParam: String {
        get {
            return searchValue
        }

        set {
            searchValue = newValue
        }
    }

    private init() {
        debugPrint("SearchHelper")
    }

}
