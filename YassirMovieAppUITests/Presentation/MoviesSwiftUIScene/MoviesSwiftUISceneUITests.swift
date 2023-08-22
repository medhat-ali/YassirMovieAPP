//
//  MoviesSwiftUISceneUITests.swift
//  YassirMovieAppUITests
//
//  Created by Medhat Ali on 22/08/2023.
//

import XCTest

class MoviesSwiftUISceneUITests: XCTestCase {

    override func setUp() {

        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testOpenMovieList() {
        
        //when app open
        let app = XCUIApplication()
              
        // then Make sure movie list appear
        XCTAssertTrue(app.tables.cells.count > 1)
    }
    
    
    func testOpenMovieDetails_whenTapOnFirstResultRow_thenMovieDetailsViewOpens() {
        //When app open
        let app = XCUIApplication()
        
        // And Tap on first result row
        _ = app.tables.cells.element(boundBy: 1).waitForExistence(timeout: 10)
        app.tables[AccessibilityIdentifier.moviesTableList].cells.element(boundBy: 1).tap()
        
        // then sure movie details view
        XCTAssertTrue(app.images[AccessibilityIdentifier.movieDetailsView].waitForExistence(timeout: 10))
        
    }
}


