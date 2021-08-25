//
//  Styles.swift
//  Styles
//
//  Created by Richard Gist on 8/25/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import Foundation
import SwiftUI

extension Text {
    func titleStyle() -> Text {
        self
            .foregroundColor(.primaryText)
            .font(.title)
            .fontWeight(.bold)
    }

    func primaryButtonStyle() -> some View {
        self
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.vertical)
            .padding(.horizontal, 50)
            .background(Color.primaryButton)
            .clipShape(Capsule())
            .shadow(color: .white.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}
