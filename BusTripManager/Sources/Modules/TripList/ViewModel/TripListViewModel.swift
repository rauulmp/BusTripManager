//
//  TripListViewModel.swift
//  BusTripManager
//
//  Created by Raul Montoya Perez on 20/6/24.
//

import RxSwift
import CoreLocation

class TripListViewModel: ObservableObject {
    
    private let tripService: TripServiceProtocol
    private let disposeBag = DisposeBag()
    var stops: [StopInfo] = []
    
    @Published var trips: [Trip] = []
    @Published var selectedTripPolylineCoordinates: [CLLocationCoordinate2D] = []
    @Published var selectedTripMapAnnotations: [TripMapAnnotation] = []
    @Published var errorMessage: String?
    
    
    init(tripService: TripServiceProtocol) {
        self.tripService = tripService
    }
    
    func fetchTrips() {
        tripService.fetchTrips()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] trips in
                    let filteredTrips = trips.filter { TripStatus(from: $0.status).isAvailable()}
                    self?.trips = filteredTrips
                },
                onError: { [weak self] error in
                    self?.errorMessage = error.localizedDescription
                }
            )
            .disposed(by: disposeBag)
    }
    
    func fetchStops() {
        tripService.fetchStops()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] stop in
                    let stops = [stop]  //Simulate that the service returns a list because stops.json returns an item
                    self?.stops = stops
                },
                onError: { [weak self] error in
                    self?.errorMessage = error.localizedDescription
                }
            )
            .disposed(by: disposeBag)
    }
    
    func selectTrip(_ trip: Trip) {
        updateTripMapAnnotations(trip)
        decodeTripPolylines(trip)
    }
    
    private func updateTripMapAnnotations(_ trip: Trip) {
        var annotations: [TripMapAnnotation] = []
        annotations.append(TripMapAnnotation(type: .limit, coordinate: trip.origin.point.toMapCoordinates()))
        annotations.append(TripMapAnnotation(type: .limit, coordinate: trip.destination.point.toMapCoordinates()))
       
        for stop in trip.stops {
            if let point = stop.point {
                let annotation = TripMapAnnotation(type: .stop, 
                                                   coordinate: point.toMapCoordinates(),
                                                   stopInfo: getAnnotationStopInfo(stopId: stop.id))
                annotations.append(annotation)
            }
        }
        
        self.selectedTripMapAnnotations = annotations
    }
    
    private func decodeTripPolylines(_ trip: Trip) {
        if let coordinates = tripService.decodePolyline(encodedPolyline: trip.route) {
            selectedTripPolylineCoordinates = coordinates
        }
        else {
            selectedTripPolylineCoordinates = []
            errorMessage = "map_polyline_decode_error".localized()
        }
    }
    
    private func getAnnotationStopInfo(stopId: Int?) -> StopInfo? {
        if !stops.isEmpty {
            for stop in stops {
                //Here we would find the stop info for the specific stop
                //I return always the first stop as there is the only one in the stops.json
                return stop
            }
        }
        return nil
    }
}
