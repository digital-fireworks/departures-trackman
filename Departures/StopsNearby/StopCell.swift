//
//  StopListItemView.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import SwiftUI
import Rejseplanen

#if DEBUG
import CoreLocation
#endif

struct StopCell: View {
    
    @State var stop: Stop
    @Environment(\.location) private var userLocation
    
    var body: some View {
        HStack {
            Text(stop.prettyName).bold()
            Spacer()
            if let userLocation = userLocation {
                let distance = stop.location.distance(from:userLocation)
                let formatted = distance.formatted()
                Text("\(formatted)")
            }
            
            #if DEBUG
            // Only for Xcode previews
            if IS_RUNNING_IN_CANVAS {
                let formatted = CLLocationDistance(Double.random(in: 0...1000)).formatted()
                Text("\(formatted)")
            }
            #endif
            
        }
    }
}

#Preview("StopListItemView") {

    List {
        StopCell(stop: Stop(name: "København H", x: 22, y: 27))
        StopCell(stop: Stop(name: "Nørreport", x: 22, y: 27))
        StopCell(stop: Stop(name: "Vesterport", x: 22, y: 27))
        StopCell(stop: Stop(name: "Kongens Nytorv", x: 22, y: 27))
    }
}
