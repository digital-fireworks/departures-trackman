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
                .tabItem {
                    Label("Nearby", systemImage: "location.circle")
                }
            
            DebugView()
                .environmentObject(locationTracker)
                .tabItem{
                    Label("Debug", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
}
