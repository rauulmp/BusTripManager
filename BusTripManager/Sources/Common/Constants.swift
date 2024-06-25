//
//  Constants.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 24/6/24.
//

import Foundation
import MapKit

struct Constants {
    
    struct Map {
        static let defaultRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.40416434673962, 
                                           longitude: 2.1742857732911025),
            span: MKCoordinateSpan(latitudeDelta: 0.05, 
                                   longitudeDelta: 0.05)
        )
    }
    
}
