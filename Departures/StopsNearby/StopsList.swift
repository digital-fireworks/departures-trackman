//
//  StopsList.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import SwiftUI
import Rejseplanen

struct StopsList: View {
    
    @Binding var stops: Stops
    
    var body: some View {
        List(stops) { stop in
            StopListItemView(stop: stop)
        }
        .animation(.default, value: stops)
    }
}
