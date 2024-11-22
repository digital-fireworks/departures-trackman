//
//  StopsNearbyView.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import SwiftUI
import Rejseplanen
import CoreLocation

struct StopsNearbyView: View {
    
    @Environment(LocationTracker.self) private var locationTracker
    @State var stops: [StopsCollection] = []
    private var rejseplanen = Rejseplanen()
    
    var body: some View {
        NavigationStack {
            VStack {
                if locationTracker.authorizationStatus == .denied {
                    Text("Location permission denied. You can change this in Settings.").multilineTextAlignment(.center)
                } else {
                    StopsList(sections: $stops)
                }
            }
            .navigationTitle("Nearby")
            // Provide current location to enable distance calculation in cells
            .environment(\.location, locationTracker.location)
        }
        .onAppear {
            // Request location tracking permission from user and start updating location
            self.locationTracker.requestWhenInUsePermission()
            self.locationTracker.startUpdatingLocation()
        }
        .onChange(of: locationTracker.location) {
            // Update nearby stops when location changes
            if let location = locationTracker.location {
                update(withLocation: location)
            }
        }
    }
    
    private func update(withLocation location: CLLocation) {
        Task {
            do {
                let trains = try await self.rejseplanen.stopsNearby(location: location, products: RejseplanenProduct.trains, maxRadius: 2000)
                let busses = try await self.rejseplanen.stopsNearby(location: location, products: RejseplanenProduct.busses, maxRadius: 500)
                let metros = try await self.rejseplanen.stopsNearby(location: location, products: RejseplanenProduct.metros, maxRadius: 1000)
                let ferries = try await self.rejseplanen.stopsNearby(location: location, products: RejseplanenProduct.ferries, maxRadius: 5000)
            
                let trainsCollection = StopsCollection(type: .trains, stops: trains)
                let busCollection = StopsCollection(type: .busses, stops: busses)
                let metrosCollection = StopsCollection(type: .metros, stops: metros)
                let ferriesCollection = StopsCollection(type: .ferries, stops: ferries)
                
                withAnimation {
                    self.stops = [trainsCollection, busCollection, metrosCollection, ferriesCollection]
                }
            } catch let error {
                // TODO: Handle error gracefully.
                // Don't reset stops to nil, as errors on the network happens periodically and mostly doesn't affect user. In general, try to avoid propagating errors to the user. Instead build retry logic or rely on non persistant state.
                print(error.localizedDescription)
            }
        }
    }
}
