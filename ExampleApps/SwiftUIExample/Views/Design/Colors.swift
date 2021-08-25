//
//  Colors.swift
//  Colors
//
//  Created by Richard Gist on 8/25/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    static var primaryBackground: Color {
//        Color.init(red: 29/255, green: 30/255, blue: 72/255)
        Color.init(red: 24/255, green: 24/255, blue: 24/255)
    }

    static var primaryText: Color {
        white
    }

    static var card: Color {
        Color.init(red: 86/255, green: 86/255, blue: 118/255)
            .opacity(0.8)
    }

    static var icon: Color {
        Color.init(red: 130/255, green: 18/255, blue: 196/255)
    }

    static var primaryButton: Color {
        Color.init(red: 130/255, green: 18/255, blue: 196/255)
    }

    static var divider: Color {
        white.opacity(0.5)
    }
}
