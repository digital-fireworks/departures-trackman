//
//  CoreLocationExtensions.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import CoreLocation

extension CLLocationDistance {
    
    static let distanceFormatter = {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 1
        return formatter
    }()
    
    func formatted() -> String {
        formatDistance(self)
    }
    
    func formatDistance(_ distance: CLLocationDistance) -> String {
        let measurement = Measurement(value: distance, unit: UnitLength.meters)
        return Double.distanceFormatter.string(from: measurement)
    }
}
