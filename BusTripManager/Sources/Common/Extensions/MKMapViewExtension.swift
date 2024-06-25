//
//  MKMapViewExtension.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import MapKit

extension MKMapView {
    
    func addPolyline(coordinates: [CLLocationCoordinate2D]) {
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        addOverlay(polyline)
    }
    
}
