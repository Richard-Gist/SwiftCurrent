//
//  SwiftCurrentOnboarding.swift
//  SwiftUIExample
//
//  Created by Tyler Thompson on 8/26/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import SwiftUI
import SwiftCurrent

struct SwiftCurrentOnboarding: View, PassthroughFlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        VStack {
            Spacer()

            Image.socialMediaIcon
                .resizable()
                .scaledToFit()
                .padding()

            VStack(spacing: 50) {
                HStack {
                    Image.password
                        .resizable()
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading) {
                        Text("Fake it till you make it!")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Foo")
                    }
                }

                HStack {
                    Image.password
                        .resizable()
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading) {
                        Text("Fake it till you make it! I thought this")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("This screen will only appear once yo and only")
                            .font(.subheadline)
                    }
                }

                HStack {
                    Image.password
                        .resizable()
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading) {
                        Text("Fake it till you make it!")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Foo")
                    }
                }
            }
            .padding()

            Spacer()

            Button {
                withAnimation {
                    proceedInWorkflow()
                }
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
