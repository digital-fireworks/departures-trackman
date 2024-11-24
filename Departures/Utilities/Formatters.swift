//
//  Formatters.swift
//  Departures
//
//  Created by Fredrik on 22/11/2024.
//

import Foundation

class Formatters {
    
    static let shared = Formatters()
    
    private init() { }
    
    lazy var departureTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
}
