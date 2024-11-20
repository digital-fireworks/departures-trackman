//
//  ContentView.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import SwiftUI
import SwiftData
import CoreLocation

struct DebugView: View {
    
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var locationTracker: LocationTracker

    var body: some View {
        VStack {
            Text("Authorization Status: \(self.locationTracker.authorizationStatus.rawValue)")
            Text("Location: \(locationTracker.location?.description ?? "No location")")
        }
        .onAppear {
            self.locationTracker.requestWhenInUsePermission()
            self.locationTracker.startUpdatingLocation()
        }
    }
}

#Preview {
    DebugView().environmentObject(LocationTracker())
}
