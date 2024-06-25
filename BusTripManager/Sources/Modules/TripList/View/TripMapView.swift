//
//  TripMapView.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 22/6/24.
//

import SwiftUI
import MapKit

struct TripMapView: UIViewRepresentable {
    
    @Binding var polylineCoordinates: [CLLocationCoordinate2D]
    @Binding var mapAnnotations: [TripMapAnnotation]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = Constants.Map.defaultRegion
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeOverlays(mapView.overlays)
        let polyline = MKPolyline(coordinates: polylineCoordinates, count: polylineCoordinates.count)
        mapView.addOverlay(polyline)
        
        mapView.removeAnnotations(mapView.annotations)
        addMapAnnotations(mapView: mapView)
        
        if let newRegion = calculateNewRegion() {
            mapView.setRegion(newRegion, animated: true)
        }
    }
    
    func makeCoordinator() -> TripMapCoordinator {
        TripMapCoordinator(self)
    }
    
    private func calculateNewRegion() -> MKCoordinateRegion? {
        guard let region = MapUtils.region(for: polylineCoordinates) else { return nil }
        return region
    }
    
    private func addMapAnnotations(mapView: MKMapView) {
        if !mapAnnotations.isEmpty {
            for mapAnnotation in mapAnnotations {
                let annotation = MapCustomPointAnnotation()
                annotation.imageName = mapAnnotation.type.imageName
                annotation.coordinate = mapAnnotation.coordinate
                mapView.addAnnotation(annotation)
            }
        }
    }
}
