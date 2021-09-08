//
//  ProfileFeatureOnboardingView.swift
//  SwiftUIExample
//
//  Created by Tyler Thompson on 7/15/21.
//
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.

import SwiftUI
import SwiftCurrent
import Swinject

struct ProfileFeatureOnboardingView: View, FlowRepresentable {
    @AppStorage("OnboardedToProfileFeature", store: .fromDI) private var onboardedToProfileFeature = false

    let inspection = Inspection<Self>() // ViewInspector
    weak var _workflowPointer: AnyFlowRepresentable?
    private let previewImage = Image.profileOnboarding
    private let previewAccent = Color.icon
    private let featureTitle = "Welcome to our new profile management feature!"
    private let featureSummary = "You can update your username and password here."

    var body: some View {
        VStack {
            VStack {
                previewImage
                    .resizable()
                    .scaledToFit()
                    .shadow(color: previewAccent, radius: 5)
                    .padding()

                Text(featureTitle)
                    .titleStyle()
                    .multilineTextAlignment(.center)
                Text(featureSummary)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                Spacer()
            }
            PrimaryButton(title: "Continue") {
                onboardedToProfileFeature = true
                proceedInWorkflow()
            }
        }.onReceive(inspection.notice) { inspection.visit(self, $0) } // ViewInspector
    }

    func shouldLoad() -> Bool {
        !onboardedToProfileFeature
    }
}

struct FeatureValue_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFeatureOnboardingView()
            .preferredColorScheme(.dark)
    }
}
