//
//  LocationTracker.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import SwiftUI
import CoreLocation

extension CLLocation {
    open override var description: String {
        "\(self.coordinate.latitude), \(self.coordinate.longitude)"
    }
}

class LocationTracker: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // Use this as default location is access to location is not auhtorized by user
    static var defaultLocation: CLLocation {
        CLLocation(latitude: 59.3294, longitude: 18.0685)
    }
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var location: CLLocation? = nil

    private let manager: CLLocationManager
    
    override init() {
        self.manager = CLLocationManager()
        self.authorizationStatus = manager.authorizationStatus
        self.location = manager.location
        super.init()
        
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    func requestWhenInUsePermission() {
        self.manager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        assert(Thread.isMainThread, "Using LocationTracker from other than main thread is not supported")
        self.manager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function + "\(manager.authorizationStatus.rawValue)")
        self.authorizationStatus = manager.authorizationStatus
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        print(#function)
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        print(#function)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        
        // `location` is part of the environment so make sure we're on main thread.
        DispatchQueue.main.async {
            self.location = locations.first
        }
        
    }
}
