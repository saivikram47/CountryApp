//
//  CountryAppTests.swift
//  CountryAppTests
//
//  Created by Apple on 28/05/25.
//

import XCTest
@testable import CountryApp

final class CountryAppTests: XCTestCase {
    
    
    func testAddCountry() {
        let vm = CountryListViewModel()
        let sample = Country(name: "TestLand", capital: "TestCity", currencies: [], alpha2Code: "TL")
        vm.addCountry(sample)
        XCTAssertTrue(vm.selectedCountries.contains(sample))
    }
    
    override func setUpWithError() throws {
  
    }

    override func tearDownWithError() throws {
      
    }

    func testExample() throws {
  
    }

    func testPerformanceExample() throws {
    
        self.measure {
        
        }
    }

}
