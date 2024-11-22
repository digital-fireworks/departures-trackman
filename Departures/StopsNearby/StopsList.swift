//
//  StopsList.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import SwiftUI
import Rejseplanen

enum StopsCollectionType {
    case trains
    case busses
    case metros
    case ferries
    
    var title: String {
        switch self {
        case .trains: return "Trains"
        case .busses: return "Busses"
        case .metros: return "Metros"
        case .ferries: return "Ferries"
        }
    }
    
    var imageName: String {
        switch self {
        case .trains: return "tram"
        case .busses: return "bus"
        case .metros: return "tram.circle"
        case .ferries: return "ferry"
        }
    }
}

struct StopsCollection {
    
    let type: StopsCollectionType
    let stops: Stops
    
}

struct StopsList: View {
    
    @Binding var sections: [StopsCollection]
    
    var body: some View {
        List($sections, id: \.type) { $stopsCollection in
            StopsSection(stopsCollection: $stopsCollection)
        }
        .listStyle(.insetGrouped)
    }
}
