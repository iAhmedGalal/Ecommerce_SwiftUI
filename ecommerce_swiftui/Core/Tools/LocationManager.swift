//
//  LocationManager.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 21/09/2025.
//

import CoreLocation
import SwiftUI

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    private let geocoder = CLGeocoder()

    @Published var address: String = ""
    @Published var locationCoordinate: CLLocationCoordinate2D?

    func requestLocation() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        manager.startUpdatingLocation()
    }
 
    func reverseGeocodeLocation(_ coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location, preferredLocale: LocalizationManager.shared.currentLocale) {[weak self] placemarks, error in
            if let placemark = placemarks?.first {
                let selectedAddress = [
                    placemark.name,
                    placemark.locality,
                    placemark.country
                ].compactMap { $0 }.joined(separator: ", ")
                
                self?.address = selectedAddress
            }
        }
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
             manager.startUpdatingLocation()
         }
     }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        guard let location = locations.last else { return }
        
        locationCoordinate = location.coordinate
        
//        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
