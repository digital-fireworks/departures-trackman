//
//  DepartureBoardView.swift
//  Departures
//
//  Created by Fredrik on 22/11/2024.
//

import SwiftUI
import Rejseplanen

struct DepartureBoardView: View {
    
    @State var stop: Stop
    
    var body: some View {
        Text("\(stop.prettyName)")
    }

}

#Preview {
    let stop = Stop(name: "København H", x: 22, y: 13)
    DepartureBoardView(stop: stop)
}
