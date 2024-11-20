//
//  ContentView.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        Text("Velkommen til Rejseplanen App")
    }
}

#Preview {
    ContentView()
}
