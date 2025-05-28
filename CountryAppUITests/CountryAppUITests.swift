//
//  CountryAppUITests.swift
//  CountryAppUITests
//
//  Created by Apple on 28/05/25.
//

import XCTest

final class CountryAppUITests: XCTestCase {

    override func setUpWithError() throws {

        continueAfterFailure = false


    }

    override func tearDownWithError() throws {
     
    }

    @MainActor
    func testExample() throws {
      
        let app = XCUIApplication()
        app.launch()

       
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
          
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
