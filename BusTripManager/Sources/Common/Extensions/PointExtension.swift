//
//  PointExtension.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 24/6/24.
//

import MapKit

extension Point {
    
    func toMapCoordinates() -> CLLocationCoordinate2D {
        let coordinates = CLLocationCoordinate2D(latitude: latitude, 
                                                 longitude: longitude)
        return coordinates
    }
    
}
