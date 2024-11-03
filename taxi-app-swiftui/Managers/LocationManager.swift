//
//  LocationManager.swift
//  taxi-app-swiftui
//
//  Created by Nikolai Margenov on 3.11.24.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    private var lastLocation: CLLocation?
    @Published public var distanceTraveled: Double = 0.0

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 3.0
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.requestWhenInUseAuthorization()

    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        lastLocation = nil
        distanceTraveled = 0.0
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }

        if let lastLocation = lastLocation {
            let distance = userLocation.distance(from: lastLocation)
            distanceTraveled += distance
        }

        lastLocation = userLocation
    }
}

