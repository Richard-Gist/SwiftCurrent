//
//  SwiftCurrentOnboarding.swift
//  SwiftUIExample
//
//  Created by Tyler Thompson on 8/26/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import SwiftUI

struct SwiftCurrentOnboarding: View {
    var body: some View {
        VStack {
            Image.socialMediaIcon
                .resizable()
                .scaledToFit()
                .padding()

            Spacer()

            VStack {
                Text("Because we r cul")
            }

            Spacer()

            Button {
//                showSignUp = true
            } label: {
                Text("Check It Out!")
                    .primaryButtonStyle()
            }
        }
    }
}

struct SwiftCurrentOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        SwiftCurrentOnboarding()
            .preferredColorScheme(.dark)
    }
}
