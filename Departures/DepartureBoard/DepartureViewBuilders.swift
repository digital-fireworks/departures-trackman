//
//  DepartureViewBuilders.swift
//  Departures
//
//  Created by Fredrik on 22/11/2024.
//

import SwiftUI
import Rejseplanen

extension Departure {
    
    @ViewBuilder
    var cellView: some View {
        HStack(spacing: 10) {
            badge
            VStack(alignment: .leading) {
                finalStopView
                    .alignmentGuide(.listRowSeparatorLeading) { d in return 0 }
                HStack {
                    // Direction is mainly used for metros and busses
                    if self.isMetroOrLightrail || self.isBus {
                        // Remove redundant information from direction view - this is especially true for busses. TODO: do this upon recieval from endpoint - i.e. on data parsing instead.
                        if let f = finalStop, let d = self.direction, !f.containsAllWords(of: d) {
                            directionView
                        }
                    }
                    // Busses don't run on tracks
                    if !self.isBus {
                        trackView
                    }
                }
            }
            Spacer()
            dateView
        }
    }
    
    @ViewBuilder
    var badge: some View {
        DepartureBadgeView(
            name: self.badgeName,
            color: self.color,
            textColor: self.badgeTextColor,
            minWidth: self.isBus ? 65 : 32 // Busses tend to have longer badgeNames so to avoid zig-zaggin in the UI set higher minWidth
        )
    }
    
    @ViewBuilder
    var sTrainNameView: some View {
        ZStack {
            Text(name).font(.direction)
        }
        .frame(minWidth: 21, idealHeight: 21)
        .padding(8)
        .background(.gray)
        .cornerRadius(8)
    }
    
    @ViewBuilder
    var finalStopView: some View {
        if self.type == .metro {
            let prettierFinalStop = finalStop?.replacingOccurrences(of: "(Metro)", with: "").trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            Text("\(prettierFinalStop)")
        } else if self.type == .lightRail {
            let prettierFinalStop = finalStop?.replacingOccurrences(of: "(Letbane)", with: "").trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            Text("\(prettierFinalStop)")
        } else {
            if let finalStop = finalStop {
                Text(finalStop.removingDuplicateParenthesizedStrings()).font(.finalStop)
            } else {
                Text("")
            }
        }
    }
    
    @ViewBuilder
    var directionView: some View {
        Text(direction ?? "").font(.track)
    }
    
    @ViewBuilder
    var trackView: some View {
        if let realtimeTrack = realtimeTrack {
            Text("Track \(realtimeTrack)")
                .font(.track)
                .foregroundColor(.secondary)
        } else if let track = track {
            Text("Track \(track)")
                .font(.track)
                .foregroundColor(.secondary)
        } else {
            Text("")
        }
    }
    
    @ViewBuilder
    var dateView: some View {
        let departureDate = self.date.formattedDepartureTime()
        if departureDate.minutes {
            VStack(alignment: .center) {
                Text("\(departureDate.string)").font(.time)
                Text("min").foregroundColor(.secondary).font(.system(size: 10, weight: .bold, design: .monospaced).width(.compressed))
            }
        } else {
            Text("\(departureDate.string)").font(.time)
        }
    }
    
}
