//
//  StopsNearbyView.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import SwiftUI
import Rejseplanen
import CoreLocation

#if DEBUG
let IS_RUNNING_IN_CANVAS: Bool = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
#endif

struct StopsNearbyView: View {
    
    @Environment(LocationTracker.self) private var locationTracker
    @State private var viewModel = StopsNearbyViewModel()
    
    var body: some View {
        ZStack {
            StopsList(stops: $viewModel.stops)
            // Provide current location through environment, to allow cells to calculate distance
                .environment(\.location, locationTracker.location)
        }
        .onAppear {
            self.locationTracker.requestWhenInUsePermission()
            self.locationTracker.startUpdatingLocation()
        }
        .onChange(of: locationTracker.location) {
            if let location = locationTracker.location {
                update(location: location)
            }
        }
    }
    
    private func update(location: CLLocation) {
        Task {
            await viewModel.update(withLocation: location)
        }
    }
}
