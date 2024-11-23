//
//  Fonts.swift
//  Departures
//
//  Created by Fredrik on 22/11/2024.
//

import SwiftUI

extension Font {
    
    static var finalStop: Font {
        return Font.system(.headline, design: .default, weight: .semibold)
    }
    
    static var direction: Font {
        return Font.system(.subheadline, design: .default, weight: .regular)
    }
    
    static var time: Font {
        return Font.system(.headline, design: .monospaced, weight: .bold)
    }
    
    static var badge: Font {
        return Font.system(.headline, design: .rounded, weight: .bold)
    }
    
    static var track: Font {
        return Font.system(.subheadline, design: .default, weight: .regular)
    }
    
}
