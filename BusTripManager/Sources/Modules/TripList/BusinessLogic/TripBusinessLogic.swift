//
//  TripBusinessLogic.swift
//  BusTripManager
//
//  Created by Raul Montoya Perez on 9/7/24.
//

import RxSwift
import CoreLocation

protocol TripBusinessLogicProtocol {
    func fetchTrips() -> Observable<[Trip]>
    func fetchStops() -> Observable<[StopInfo]>
    func decodePolyline(encodedPolyline: String) -> [CLLocationCoordinate2D]?
}

class TripBusinessLogic: TripBusinessLogicProtocol {
    private let tripService: TripServiceProtocol
    
    init(tripService: TripServiceProtocol) {
        self.tripService = tripService
    }
    
    func fetchTrips() -> Observable<[Trip]> {
        return tripService.fetchTrips().map { trips in
            return trips.filter { TripStatus(from: $0.status).isAvailable() }
        }
    }
    
    func fetchStops() -> Observable<[StopInfo]> {
        return tripService.fetchStops().map { stop in
            return [stop] //Simulate that the service returns a list because stops.json returns an item
        }
    }
    
    func decodePolyline(encodedPolyline: String) -> [CLLocationCoordinate2D]? {
        return tripService.decodePolyline(encodedPolyline: encodedPolyline)
    }
}
