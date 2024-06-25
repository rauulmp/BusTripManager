//
//  MapCustomPointAnnotation.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import MapKit

class MapCustomPointAnnotation: MKPointAnnotation {
    
    var type: TripMapAnnotationType?
    var stopInfo: StopInfo?
    
    override init() {
        super.init()
    }
    
}
