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
                    Image(systemName: "point.topleft.down.curvedto.point.bottomright.up")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading) {
                        Text("Define your app in workflows!")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Views remain ignorant of the flow they're in.")
                    }
                    Spacer()
                }

                HStack {
                    Image(systemName: "arrow.triangle.swap")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading) {
                        Text("Optionally skip screens.")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("This screen will only appear once even though the workflow hasn't changed.")
                            .font(.subheadline)
                    }
                    Spacer()
                }

                HStack {
                    Image(systemName: "arrow.triangle.branch")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading) {
                        Text("Compose workflows together")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Create branching flows by defining new workflows and launching them.")
                    }
                    Spacer()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
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
