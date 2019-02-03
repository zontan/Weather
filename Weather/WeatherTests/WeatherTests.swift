//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Jonathan  Fotland on 1/31/19.
//  Copyright © 2019 Jonathan Fotland. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Weather

class WeatherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetWeather() {
        let controllerUnderTest = ViewController()
        
        let expectation = XCTestExpectation(description: "Get location data")
        let weatherExpectation = XCTestExpectation(description: "Get Weather object")
        controllerUnderTest.getCoordinates(location: "San Jose, California") { (location) in
            expectation.fulfill() //This callback only happens if location gathering was successful
            
            APIWrapper.sharedInstance.getForecast(for: location, callback: { (weather, error) in
                
                XCTAssertNil(error)
                XCTAssertNotNil(weather)
                XCTAssertNotNil(weather?.getWeatherCondition())
                XCTAssertNotNil(weather?.getPrecipitationChance())
                XCTAssertNotNil(weather?.getPressure())
                XCTAssertNotNil(weather?.getTemperature())
                XCTAssertNotNil(weather?.getHumidity())
                weatherExpectation.fulfill()
            })
        }
        
        wait(for: [expectation, weatherExpectation], timeout: 15.0)
    }
    
}
