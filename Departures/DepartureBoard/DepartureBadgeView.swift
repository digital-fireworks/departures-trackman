//
//  DepartureBadgeView.swift
//  Departures
//
//  Created by Fredrik on 22/11/2024.
//

import SwiftUI
import Rejseplanen

extension Departure {
    
    var badgeName: String {
        switch self.type {
        case .tog:
            if self.name.contains("EC ") {
                return "EC"
            } else {
                return self.name.replacingOccurrences(of: "Lokalbane ", with: "")
            }
        case .bus, .expressBus, .nightBus:
            return self.name
                .replacingOccurrences(of: "Bus ", with: "")
                .replacingOccurrences(of: "X ", with: "")
                .replacingOccurrences(of: "Bybus ", with: "")
                .replacingOccurrences(of: "Natbus ", with: "")
        case .metro:
            return self.name.replacingOccurrences(of: "Metro ", with: "")
        case .lightRail:
            return self.name.replacingOccurrences(of: "Letbane ", with: "")
        case .regional:
            return "Re"
        case .intercity:
            return "IC"
        case .lyn:
            return "ICL"
        default:
            return self.name
        }
    }
}

struct DepartureBadgeView: View {
    
    let name: String
    let color: Color
    let textColor: Color
    let minWidth: Double
    
    init(name: String, color: Color, textColor: Color = .departureBadgeTextColorLight, minWidth: Double = 32) {
        self.name = name
        self.color = color
        self.textColor = textColor
        self.minWidth = minWidth
    }
    
    var body: some View {
        ZStack {
            Text(name)
                .foregroundColor(textColor)
                .font(.badge)
                .padding([.leading, .trailing], 6)
        }
        .frame(minWidth: minWidth, minHeight: 32)
        .background(color.gradient)
        .cornerRadius(7)
    }
    
}

#Preview {
    List {
        HStack {
            DepartureBadgeView(name: "250S", color: .sTrainLineA)
            Text("København H")
            Spacer()
            Text("23:43").bold()
        }
    }
}
