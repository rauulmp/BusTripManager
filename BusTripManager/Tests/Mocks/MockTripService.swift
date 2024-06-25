//
//  MockTripService.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 22/6/24.
//

import RxSwift
import Polyline

class MockTripService: TripServiceProtocol {
    
    var mockFetchTripsResult: Observable<[Trip]>?
    
    func fetchTrips() -> Observable<[Trip]> {
        //Check if we set observable result manually
        if let mockFetchTripsResult = mockFetchTripsResult {
            return mockFetchTripsResult
        }
        return Observable.just(getMockTrips())
    }
    
    func decodePolyline(encodedPolyline: String) -> [LocationCoordinate2D]? {
        return getMockPolylines()
    }
    
    private func getMockTrips() -> [Trip] {
        let mockTrips = [
            Trip(driverName: "Driver1", status: "ongoing", route: "routee", startTime: "start time", origin: Location(address: "originLocation1", point: Point(latitude: 0.0, longitude: 0.0)), description: "trip1 desc", destination: Location(address: "destinationLocation1", point: Point(latitude: 0.0, longitude: 0.0)), stops: [], endTime: "endTime"),
            Trip(driverName: "Driver2", status: "ongoing", route: "routee", startTime: "start time", origin: Location(address: "originLocation2", point: Point(latitude: 0.0, longitude: 0.0)), description: "trip1 desc", destination: Location(address: "destinationLocation2", point: Point(latitude: 0.0, longitude: 0.0)), stops: [], endTime: "endTime"),
            Trip(driverName: "Driver3", status: "ongoing", route: "routee", startTime: "start time", origin: Location(address: "originLocation3", point: Point(latitude: 0.0, longitude: 0.0)), description: "trip1 desc", destination: Location(address: "destinationLocation3", point: Point(latitude: 0.0, longitude: 0.0)), stops: [], endTime: "endTime")
        ]
        return mockTrips
    }
    
    private func getMockPolylines() -> [LocationCoordinate2D]? {
        return nil
    }
}
