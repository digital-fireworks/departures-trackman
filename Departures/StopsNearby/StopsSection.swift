//
//  StopsSection.swift
//  Departures
//
//  Created by Fredrik on 22/11/2024.
//
//
import SwiftUI
import Rejseplanen

struct StopsSection: View {
    
    @Binding var stopsCollection: StopsCollection

    var body: some View {
        Section {
            ForEach(stopsCollection.stops) { stop in
                NavigationLink(destination: DepartureBoardView(stop: stop)) {
                    StopCell(stop: stop)
                }
            }
        } header: {
            if self.stopsCollection.stops.count > 0 {
                HStack {
                    Image(systemName: stopsCollection.type.imageName)
                    Text(stopsCollection.type.title)
                }
            }
        }
    }
}
