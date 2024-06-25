//
//  TripServiceTests.swift
//  BusTripManagerTests
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import XCTest
import RxTest
import RxSwift
@testable import BusTripManager

class TripServiceTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    var service: TripService!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        service = TripService()
    }
    
    override func tearDown() {
        disposeBag = nil
        service = nil
        super.tearDown()
    }
    
    func testFetchTripsSuccess() {
        // Arrange
        var fetchedTrips: [Trip] = []
        var error: Error?
        
        // Act
        let expectation = self.expectation(description: "Fetch trips expectation")
        service.fetchTrips()
            .subscribe(onNext: { trips in
                fetchedTrips = trips
                expectation.fulfill()
            }, onError: { err in
                error = err
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // Assert
        XCTAssertNil(error)
        XCTAssertFalse(fetchedTrips.isEmpty)
    }
    
    func testFetchStopsSuccess() {
        // Arrange
        var fetchedStop: StopInfo?
        var error: Error?
        
        // Act
        let expectation = self.expectation(description: "Fetch stops expectation")
        service.fetchStops()
            .subscribe(onNext: { stop in
                fetchedStop = stop
                expectation.fulfill()
            }, onError: { err in
                error = err
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // Assert
        XCTAssertNil(error)
        XCTAssertNotNil(fetchedStop)
    }
    
    func testFetchTripsFailure() {
        // Arrange
        var fetchedTrips: [Trip] = []
        var error: Error?
        
        // Act
        let expectation = self.expectation(description: "Fetch trips failure expectation")
        service.fetch(endpointName: "invalid_endpoint.json", responseType: [Trip].self)
            .subscribe(onNext: { trips in
                fetchedTrips = trips
                expectation.fulfill()
            }, onError: { err in
                error = err
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // Assert
        XCTAssertNotNil(error)
        XCTAssertTrue(fetchedTrips.isEmpty)
    }
    
    func testDecodePolyline() {
        // Arrange
        let encodedPolyline = "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@"
        
        // Act
        let coordinates = service.decodePolyline(encodedPolyline: encodedPolyline)
        
        // Assert
        XCTAssertNotNil(coordinates)
        XCTAssertFalse(coordinates!.isEmpty)
    }
    
    func testDecodeInvalidPolyline() {
        // Arrange
        let encodedPolyline = "invalidPolyline"
        
        // Act
        let coordinates = service.decodePolyline(encodedPolyline: encodedPolyline)
        
        // Assert
        XCTAssertNil(coordinates)
    }
}
