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
        updateOverlays(mapView)
        updateAnnotations(mapView)
        
        if let newRegion = calculateNewRegion() {
            mapView.setRegion(newRegion, animated: true)
        }
    }
    
    func makeCoordinator() -> TripMapCoordinator {
        TripMapCoordinator(self)
    }
    
    private func updateOverlays(_ mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        mapView.addPolyline(coordinates: polylineCoordinates)
    }
    
    private func updateAnnotations(_ mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(mapAnnotations.map { $0.toAnnotation() })
    }
    
    private func calculateNewRegion() -> MKCoordinateRegion? {
        guard let region = MapUtils.region(for: polylineCoordinates) else { return nil }
        return region
    }
    
}
