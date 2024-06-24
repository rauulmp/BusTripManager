//
//  TripMapView.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 22/6/24.
//

import SwiftUI
import MapKit

struct TripMapView: View {
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.40416434673962, longitude: 2.1742857732911025),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        Map(coordinateRegion: $region).frame(height: 300)
    }
}
