//
//  ContentView.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    private var locationTracker = LocationTracker()
    
    var body: some View {
        TabView {
            StopsNearbyView()
                .environment(locationTracker)
                .tabItem {
                    Label("Nearby", systemImage: "location.circle")
                }
            
            #if DEBUG
            DebugView()
                .environment(locationTracker)
                .tabItem{
                    Label("Debug", systemImage: "gear")
                }
            #endif
        }
    }
}
