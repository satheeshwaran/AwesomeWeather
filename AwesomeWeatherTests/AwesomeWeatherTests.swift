//
//  AwesomeWeatherTests.swift
//  AwesomeWeatherTests
//
//  Created by Satheeshwaran Jeevanandan - (Digital) on 20/05/20.
//  Copyright © 2020 Satheeshwaran Jeevanandan - (Digital). All rights reserved.
//

import XCTest
@testable import AwesomeWeather

class AwesomeWeatherTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCityWeather() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = self.expectation(description: "testCityWeather")
        var result: [String:AnyObject]?
        WeatherManager.sharedInstance().getWeatherForPlace(place: "Chennai") { (response) in
            print(response);
            result = response
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert((result != nil), "Response should not be nil")
        XCTAssert(result?.keys.count != 0, "Response should not be empty")
    }


}
