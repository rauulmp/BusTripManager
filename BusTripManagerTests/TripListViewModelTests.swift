//
//  TripListViewModelTests.swift
//  BusTripManagerTests
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import XCTest
import RxTest
import RxSwift
@testable import BusTripManager

final class TripListViewModelTests: XCTestCase {

    var viewModel: TripListViewModel!
    var mockTripService: MockTripService!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        mockTripService = MockTripService()
        viewModel = TripListViewModel(tripService: mockTripService)
    }
    
    override func tearDown() {
        disposeBag = nil
        scheduler = nil
        mockTripService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchTripsSuccess() {
        // Arrange
        let trips = [
            Trip(driverName: "Driver1",
                 status: "ongoing",
                 route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@",
                 startTime: "2018-12-19T08:00:00.000Z",
                 origin: Location(address: "originLocation1", point: Point(latitude: 41.38074, longitude: 2.18594)),
                 description: "trip1 description",
                 destination: Location(address: "destinationLocation1", point: Point(latitude: 41.49958, longitude: 1.90307)),
                 stops: [Stop(point: Point(latitude: 41.35179, longitude: 2.15494), id: 1)],
                 endTime: "2018-12-19T10:00:00.000Z"),
            Trip(driverName: "Driver2",
                 status: "scheduled",
                 route: "",
                 startTime: "2018-12-18T08:00:00.000Z",
                 origin: Location(address: "originLocation2", point: Point(latitude: 0.0, longitude: 0.0)),
                 description: "trip2 description",
                 destination: Location(address: "destinationLocation2", point: Point(latitude: 0.0, longitude: 0.0)),
                 stops: [],
                 endTime: "2018-12-18T09:00:00.000Z")
        ]
        mockTripService.mockFetchTripsResult = Observable.just(trips)
        
        // Act
        viewModel.fetchTrips()
        
        // Assert
        XCTAssertEqual(viewModel.trips.count, 2)
        XCTAssertEqual(viewModel.trips.first?.driverName, "Driver1")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchTripsFailure() {
        // Arrange
        let error = NSError(domain: "ErrorDomain", code: 500, userInfo: nil)
        mockTripService.mockFetchTripsResult = Observable.error(error)

        // Act
        viewModel.fetchTrips()

        // Assert
        XCTAssertEqual(viewModel.trips.count, 0)
        XCTAssertEqual(viewModel.errorMessage, error.localizedDescription)
    }
    
    func testFetchStopsSuccess() {
        // Arrange
        let stops = StopInfo(price: 1.5,
                                 address: "Ramblas, Barcelona",
                                 tripId: 1,
                                 paid: true,
                                 stopTime: "2018-12-18T08:10:00.000Z",
                                 point: Point(latitude: 41.37653, longitude: 2.17924),
                                 userName: "Manuel Gomez")
        mockTripService.mockFetchStopsResult = Observable.just(stops)
        
        // Act
        viewModel.fetchStops()
        
        // Assert
        XCTAssertEqual(viewModel.stops.count, 1)
        XCTAssertEqual(viewModel.stops.first?.address, "Ramblas, Barcelona")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchStopsFailure() {
        // Arrange
        let error = NSError(domain: "ErrorDomain", code: 500, userInfo: nil)
        mockTripService.mockFetchStopsResult = Observable.error(error)
        
        // Act
        viewModel.fetchStops()
        
        // Assert
        XCTAssertEqual(viewModel.stops.count, 0)
        XCTAssertEqual(viewModel.errorMessage, error.localizedDescription)
    }
}

