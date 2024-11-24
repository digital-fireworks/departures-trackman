//
//  DateExtensions.swift
//  Departures
//
//  Created by Fredrik on 24/11/2024.
//

import Foundation

extension Date {
    
    /// Returns a user friendly formatted departure time string. If the departure time is less than 30 minutes from now, the string will return number of minutes, in all other cases it will return the departure time in the format `HH:mm`
    func formattedDepartureTime() -> (string: String, minutes: Bool) {
        let seconds = self.timeIntervalSinceNow - 30 // We pull off 30 seconds for user experience. Rather be 30 seconds too early than too late.
        let minutes = Int(seconds / 60)
        
        if seconds < 0 {
            return ("0", true)
        } else if seconds < 60 {
            return ("½", true)
        } else if minutes < 30 {
            return ("\(minutes)", true)
        } else {
            return (Formatters.shared.departureTimeFormatter.string(from: self), false)
        }
    }
}
