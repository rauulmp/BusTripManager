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
    var mockFetchStopsResult: Observable<StopInfo>?
    
    func fetchTrips() -> Observable<[Trip]> {
        //Check if we set observable result manually
        if let mockFetchTripsResult = mockFetchTripsResult {
            return mockFetchTripsResult
        }
        return Observable.just(getMockTrips())
    }
    
    func fetchStops() -> Observable<StopInfo> {
        //Check if we set observable result manually
        if let mockFetchStopsResult = mockFetchStopsResult {
            return mockFetchStopsResult
        }
        return Observable.just(getMockStops())
    }
    
    func decodePolyline(encodedPolyline: String) -> [LocationCoordinate2D]? {
        if !encodedPolyline.isEmpty {
            return Polyline(encodedPolyline: encodedPolyline).coordinates
        }
        return getMockPolylines()
    }
    
    private func getMockTrips() -> [Trip] {
        let mockTrips = [
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
                 endTime: "2018-12-18T09:00:00.000Z"),
            Trip(driverName: "Driver3", 
                 status: "cancelled",
                 route: "",
                 startTime: "2018-11-18T19:00:00.000Z",
                 origin: Location(address: "originLocation3", point: Point(latitude: 0.0, longitude: 0.0)),
                 description: "trip3 description",
                 destination: Location(address: "destinationLocation3", point: Point(latitude: 0.0, longitude: 0.0)),
                 stops: [],
                 endTime: "2018-11-18T09:00:00.000Z")
        ]
        return mockTrips
    }
    
    private func getMockStops() -> StopInfo {
        let mockStops = StopInfo(price: 1.5,
                                 address: "Ramblas, Barcelona",
                                 tripId: 1,
                                 paid: true,
                                 stopTime: "2018-12-18T08:10:00.000Z",
                                 point: Point(latitude: 41.37653, longitude: 2.17924),
                                 userName: "Manuel Gomez")
        return mockStops
    }
    
    private func getMockPolylines() -> [LocationCoordinate2D]? {
        return nil
    }
}
