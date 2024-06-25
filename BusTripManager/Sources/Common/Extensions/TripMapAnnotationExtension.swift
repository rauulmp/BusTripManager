//
//  TripMapAnnotationExtension.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import MapKit

extension TripMapAnnotation {
    
    func toAnnotation() -> MKAnnotation {
        let annotation = MapCustomPointAnnotation()
        annotation.imageName = type.imageName
        annotation.coordinate = coordinate
        return annotation
    }
    
}
