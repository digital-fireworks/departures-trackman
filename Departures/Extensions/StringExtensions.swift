//
//  StringExtensions.swift
//  Departures
//
//  Created by Fredrik on 24/11/2024.
//

import Foundation

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
