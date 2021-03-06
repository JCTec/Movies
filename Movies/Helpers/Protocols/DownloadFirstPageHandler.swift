//
//  DownloadFirstPageHandler.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation

public protocol DownloadFirstPageHandler: ErrorHandler {
    func didStartDownloadingFirstPage()
    func didFinishDownloadingFirstPage(movies: [Movie])
}
