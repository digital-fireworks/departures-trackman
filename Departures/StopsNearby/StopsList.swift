//
//  StopsList.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import SwiftUI
import Rejseplanen

// TODO: Consider using DepartureBoardType instead, as this has the same values. The purpose of both this and DepartureBoardType is to allow for a better user experience by showing the most relevant products given the context for the user, i.e. if the user is interested in busses, indicated by selecting from the bus stops, the departure board for the stop should show busses only or as the first section.
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

extension StopsCollectionType {
    
    var departureBoardType: DepartureBoardType {
        switch self {
        case .trains: return .trains
        case .busses: return .busses
        case .metros: return .metros
        default: return .all
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
