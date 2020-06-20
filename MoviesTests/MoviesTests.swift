//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Juan Carlos on 19/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesTests: XCTestCase {

    override func setUpWithError() throws {
        API.settings.apiKey = "4cb1eeab94f45affe2536f2c684a5c9e"
    }

    // MARK: - APISettings
    func testAPISettings() throws {
        XCTAssertEqual(API.settings.apiKey, "?api_key=4cb1eeab94f45affe2536f2c684a5c9e")
        
        API.settings.apiKey = "TEST"
        XCTAssertEqual(API.settings.apiKey, "?api_key=TEST")
    }
    
    // MARK: - Find Movie API
    func testFind() throws {
        let expectation = XCTestExpectation(description: "Find API")
        
        API.movie.find(id: 717278) { (result) in
            switch result {
                case .success(let movie):
                    XCTAssertEqual(movie.originalTitle, "Bolshoi Ballet: Lost Illusions")
                case .failure(_):
                    XCTAssertTrue(false)
            }
            
            expectation.fulfill()
        }
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 15.0)
        XCTAssertEqual(result, .completed)
    }
    
    // MARK: - Search Movie API
    func testSearch() throws {
        let expectation = XCTestExpectation(description: "Search API")

        API.lists.search(query: "Test") { (result) in
            switch result {
                case .success(let movie):
                    XCTAssertNotNil(movie)
                case .failure(_):
                    XCTAssertTrue(false)
            }
            
            expectation.fulfill()
        }
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 15.0)
        XCTAssertEqual(result, .completed)
    }
    
    // MARK: - List of Movies of type.
    func testOfType() throws {
        let latest = XCTestExpectation(description: "OfType latest API")
        let popular = XCTestExpectation(description: "OfType popular API")
        let topRated = XCTestExpectation(description: "OfType topRated API")
        let nowPlaying = XCTestExpectation(description: "OfType nowPlaying API")
        let upcoming = XCTestExpectation(description: "OfType upcoming API")
        
        API.lists.ofType(.latest) { (result) in
            switch result {
                case .success(let movie):
                    XCTAssertNotNil(movie)
                    XCTAssertEqual(movie.count, 1)
                case .failure(_):
                    XCTAssertTrue(false)
            }
            
            latest.fulfill()
        }
        
        API.lists.ofType(.popular) { (result) in
            switch result {
                case .success(let movie):
                    XCTAssertNotNil(movie)
                case .failure(_):
                    XCTAssertTrue(false)
            }
            
            popular.fulfill()
        }

        API.lists.ofType(.topRated) { (result) in
            switch result {
                case .success(let movie):
                    XCTAssertNotNil(movie)
                case .failure(_):
                    XCTAssertTrue(false)
            }
            
            topRated.fulfill()
        }
        
        API.lists.ofType(.nowPlaying) { (result) in
            switch result {
                case .success(let movie):
                    XCTAssertNotNil(movie)
                case .failure(_):
                    XCTAssertTrue(false)
            }
            
            nowPlaying.fulfill()
        }
        
        API.lists.ofType(.upcoming) { (result) in
            switch result {
                case .success(let movie):
                    XCTAssertNotNil(movie)
                case .failure(_):
                    XCTAssertTrue(false)
            }
            
            upcoming.fulfill()
        }
        
        let result = XCTWaiter.wait(for: [popular, latest, topRated, nowPlaying, upcoming], timeout: 50.0)
        XCTAssertEqual(result, .completed)
    }
    
    // MARK: - Favourite Movie
    func testFavourite() throws {
        let ofType = XCTestExpectation(description: "Of Type Movie")
        let favourite = XCTestExpectation(description: "Favourite Movie")
        let allfavourite = XCTestExpectation(description: "All favourite Movie")

        API.lists.ofType(.latest) { (result) in
            switch result {
                case .success(let movie):
                    XCTAssertNotNil(movie.first)
                    let favMovie = movie.first!
                
                    API.movie.favourite(favMovie) { (record) in
                        switch result {
                            case .success(let rec):
                                XCTAssertNotNil(rec)
                            
                                API.movie.allfavourite { (result) in
                                    switch result {
                                        case .success(let fav):
                                            let predicate = fav.filter { $0.id == favMovie.id }
                                            XCTAssertEqual(predicate.count, 1)
                                        case .failure(_):
                                            XCTAssertTrue(false)
                                    }
                                    
                                    allfavourite.fulfill()
                                }
                            case .failure(_):
                                XCTAssertTrue(false)
                        }
                        
                        favourite.fulfill()
                    }
                case .failure(_):
                    XCTAssertTrue(false)
            }
            
            ofType.fulfill()
        }
        
        let result = XCTWaiter.wait(for: [ofType, favourite, allfavourite], timeout: 80.0)
        XCTAssertEqual(result, .completed)
    }

}
