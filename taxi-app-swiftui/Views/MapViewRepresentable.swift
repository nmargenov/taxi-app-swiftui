//
//  MapViewRepresentable.swift
//  taxi-app-swiftui
//
//  Created by Nikolai Margenov on 3.11.24.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    @ObservedObject var locationManager: LocationManager

    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.showsUserTrackingButton.toggle()
        
        return mapView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) { }

    func makeCoordinator() -> MapCordinator {
        return MapCordinator(parent: self)
    }
    
    func stopRide(){
        locationManager.stopUpdatingLocation()
    }
    
    func startRide(){
        locationManager.startUpdatingLocation()
        
    }
}


extension MapViewRepresentable {
    class MapCordinator: NSObject, MKMapViewDelegate {
        let parent: MapViewRepresentable
        
        init(parent: MapViewRepresentable){
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        }
    }
}

