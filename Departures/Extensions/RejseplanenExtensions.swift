//
//  RejseplanenExtensions.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import Foundation
import Rejseplanen
import SwiftUI

extension String {
    
    func containsAllWords(of other: String) -> Bool {
        // Split both strings into words
        let wordsInSelf = Set(self.lowercased().components(separatedBy: CharacterSet.alphanumerics.inverted))
        let wordsInOther = Set(other.lowercased().components(separatedBy: CharacterSet.alphanumerics.inverted))
        
        // Check if all words in 'other' are present in 'self'
        return wordsInOther.isSubset(of: wordsInSelf)
    }

    func removingDuplicateParenthesizedStrings() -> String {
        // Regular expression to match strings in parentheses
        let regex = #"\(([^)]+)\)"#

        // Find matches using NSRegularExpression
        guard let regexPattern = try? NSRegularExpression(pattern: regex) else {
            return self // Return original string if regex initialization fails
        }

        var result = self
        let matches = regexPattern.matches(in: self, range: NSRange(self.startIndex..., in: self))

        // Iterate over matches in reverse to avoid range shifts when modifying the string
        for match in matches.reversed() {
            if let range = Range(match.range(at: 1), in: self) {
                let parenthesizedString = String(self[range])

                // Check if the parenthesized string exists outside the parentheses
                let withoutParentheses = result.replacingOccurrences(of: "(\(parenthesizedString))", with: "")
                if withoutParentheses.contains(parenthesizedString) {
                    result = withoutParentheses
                }
            }
        }

        return result
    }
}

extension Stop {
    
    /// Removes parenthesis and everything in between, i.e. "København H (togbus)" will return "København H"
    var prettyName: String {
        return self.name.removingDuplicateParenthesizedStrings()
        /*
        let pattern = "\\s*\\([^)]*\\)"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: name.utf16.count)
        return regex?.stringByReplacingMatches(in: name, options: [], range: range, withTemplate: "").trimmingCharacters(in: .whitespacesAndNewlines) ?? name
         */
    }
    
}

extension Departure {
    
    var badgeTextColor: Color {
        if self.type == .nightBus {
            return .departureBadgeTextColorNightBus
        } else if [DepartureType.bus, .expressBus, .teleBus].contains(self.type) { return .departureBadgeTextColorDark }
        else { return .departureBadgeTextColorLight }
    }
    
    var isBus: Bool {
        [DepartureType.bus, .expressBus, .nightBus, .teleBus].contains(self.type)
    }
    
    var isMetroOrLightrail: Bool {
        [.metro, .lightRail].contains(self.type)
    }
    
}

extension DepartureBoard {
    
    // TODO: This should be enums
    var sTrains: [Departure] { departures.filter { $0.type == .stog } }
    var otherTrains: [Departure] { departures.filter {
        [.intercity, .lyn, .regional, .tog, .unknown].contains($0.type)
    } }
    var busses: [Departure] { departures.filter {
        [.bus, .expressBus, .nightBus, .teleBus].contains($0.type)
    } }
    var metros: [Departure] { departures.filter {
        [.metro, .lightRail].contains($0.type)
    } }
    var ferries: [Departure] { departures.filter { $0.type == .ferry } }
    var other: [Departure] { departures.filter { $0.type == .unknown } }
}

extension Departure {
    
    var color: Color {
        switch self.type {
        case .stog:
            switch self.badgeName.lowercased() {
            case "a": return Color.sTrainLineA
            case "b": return Color.sTrainLineB
            case "c": return Color.sTrainLineC
            case "e": return Color.sTrainLineE
            case "f": return Color.sTrainLineF
            case "h": return Color.sTrainLineH
            case "m": return Color.sTrainLineM
            case "bx": return Color.sTrainLineBx
            default: return Color.defaultLine
            }
        case .tog:
            switch self.badgeName.lowercased() {
            case "ec":
                return Color.eurocityTrain
            default:
                return Color.defaultLine
            }
        case .regional:
            switch self.badgeName.lowercased() {
            case "ic", "ie", "il", "l":
                return Color.trainIntercity
            case "re":
                return Color.trainRegional
            case "ø":
                return Color.trainOresund
            case "ec":
                return Color.eurocityTrain
            default:
                return Color.trainRegional
            }
        case .intercity:
            return Color.trainIntercity
        case .lyn:
            return Color.trainIntercityLyn
        case .bus, .expressBus:
            return Color.bus
        case .nightBus:
            return Color.nightBus
        case .lightRail:
            return Color.aarhusLetbane
        case .metro:
            return Color.metro
        default:
            return Color.defaultLine
        }
    }
    
}
