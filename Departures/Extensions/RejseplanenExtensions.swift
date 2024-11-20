//
//  RejseplanenExtensions.swift
//  Departures
//
//  Created by Fredrik Nannestad on 20/11/2024.
//

import Foundation
import Rejseplanen

extension Stop {
    
    /// Removes parenthesis and everything in between, i.e. "København H (togbus)" will return "København H"
    var prettyName: String {
        let pattern = "\\s*\\([^)]*\\)"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: name.utf16.count)
        return regex?.stringByReplacingMatches(in: name, options: [], range: range, withTemplate: "").trimmingCharacters(in: .whitespacesAndNewlines) ?? name
    }
    
}
