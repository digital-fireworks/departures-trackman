//
//  DepartureBoardView.swift
//  Departures
//
//  Created by Fredrik on 22/11/2024.
//

import Foundation
import SwiftUI
import Rejseplanen

struct DepartureBoardView: View {
    
    @State var stop: Stop
    @State var type: DepartureBoardType
    @State private var departureBoard: DepartureBoard? = nil
    
    var rejseplanen = Rejseplanen()
    
    var body: some View {
        VStack {
            if let departureBoard = departureBoard {
                List {
                    // TODO: Make this generic, i.e. iterate through all departure board sections and let each section know it's view configuration...
                    Section {
                        ForEach(departureBoard.sTrains) { departure in
                            departure.cellView
                        }
                    }
                    // TODO: ... to avoid this same code repeating ...
                    Section {
                        ForEach(departureBoard.metros) { departure in
                            departure.cellView
                        }
                    }
                    Section {
                        ForEach(departureBoard.otherTrains) { departure in
                            departure.cellView
                        }
                    }
                    Section {
                        ForEach(departureBoard.busses) { departure in
                            departure.cellView
                        }
                    }
                }.refreshable {
                    await update()
                }
            } else {
                ProgressView().progressViewStyle(.circular)
            }
        }
        .navigationTitle("\(stop.prettyName)")
        .task {
            await update()
        }
    }
    
    private func update() async {
        do {
            // TODO: Fetch 3 three departure boards; one for each type: train, metro, bus
            let departureBoard = try await self.rejseplanen.departureBoard(ofType: self.type, forStop: stop)
            
            withAnimation {
                self.departureBoard = departureBoard
            }
        } catch {
            // TODO: Handle error
        }
    }

}

#Preview {
    let stop = Stop(name: "København H", x: 22, y: 13)
    DepartureBoardView(stop: stop, type: .all)
}
