//
//  StopsNearbyViewModel.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import Foundation
import Rejseplanen
import CoreLocation

@MainActor
@Observable
class StopsNearbyViewModel {
    
    // TODO: Enable filtering on stop types by products
    var stops: [Stop] = []
    var error: Error?
    
    private var rejseplanen: Rejseplanen = .init()
    
    func update(withLocation location: CLLocation, products: [RejseplanenProduct]? = nil, maxRadius: CLLocationDistance? = nil) async {
        do {
            self.stops = try await rejseplanen.stopsNearby(location: location, products: products, maxRadius: maxRadius)
        } catch {
            // TODO: Handle specific errors
            self.error = error
        }
    }
}
