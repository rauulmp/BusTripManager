//
//  TripMapAnnotation.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 24/6/24.
//

import MapKit

struct TripMapAnnotation {
    let type: TripMapAnnotationType
    let coordinate: CLLocationCoordinate2D
    let stopInfo: StopInfo?
    
    init(type: TripMapAnnotationType, coordinate: CLLocationCoordinate2D, stopInfo: StopInfo? = nil) {
        self.type = type
        self.coordinate = coordinate
        self.stopInfo = stopInfo
    }
}
