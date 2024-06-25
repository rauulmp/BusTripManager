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
    var calloutView: UIView?
    
    
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
        
        if let imageName = customAnnotation.type?.imageName, let image = UIImage(systemName: imageName) {
            annotationView!.set(image: image, with: .red)
        } else {
            annotationView!.image = UIImage()
        }
    
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let customAnnotation = view.annotation as? MapCustomPointAnnotation,
                let stopInfo = customAnnotation.stopInfo else { return }
            
        calloutView?.removeFromSuperview()
            
        let hostingControllerView = TripMapStopCalloutView(stopInfo: stopInfo)
        let calloutView = UIHostingController(rootView: hostingControllerView).view
        calloutView?.backgroundColor = .clear
        calloutView?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(calloutView!)
        self.calloutView = calloutView
        
        NSLayoutConstraint.activate([
            calloutView!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calloutView!.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -8),
            calloutView!.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
            calloutView!.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        calloutView?.removeFromSuperview()
    }
}
