//
//  TripMapCoordinator.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 24/6/24.
//

import MapKit
import SwiftUI

class TripMapCoordinator: NSObject, MKMapViewDelegate {
    var parent: TripMapView
    
    init(_ parent: TripMapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .red
            renderer.lineWidth = 4
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let customAnnotation = annotation as? MapCustomPointAnnotation else {
            return nil
        }
        
        let identifier = MapCustomPointAnnotation.self.description()
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: customAnnotation, reuseIdentifier: identifier)
        } else {
            annotationView!.annotation = customAnnotation
        }
        
        if let imageName = customAnnotation.imageName, let image = UIImage(systemName: imageName) {
            annotationView!.set(image: image, with: .red)
        } else {
            annotationView!.image = UIImage()
        }
    
        return annotationView
    }
}
