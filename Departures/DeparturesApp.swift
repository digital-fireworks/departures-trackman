//
//  DeparturesApp.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import SwiftUI
import SwiftData

@main
struct DeparturesApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(self.sharedModelContainer)
    }
    
    // MARK: SwiftData
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            // TODO: Add models
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
