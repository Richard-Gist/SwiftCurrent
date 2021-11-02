//
//  SwiftUIExampleApp.swift
//  SwiftUIExample
//
//  Created by Tyler Thompson on 7/15/21.
//
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.

import SwiftUI
import Swinject
import SwiftCurrent_SwiftUI
import SwiftCurrent

@main
struct SwiftUIExampleApp: App {
    init() {
        Container.default.register(UserDefaults.self) { _ in UserDefaults.standard }
    }

    @State var wf = Workflow(viewy: SwiftCurrentOnboarding.self)
                .thenFRnProceed(with: SwiftCurrentOnboarding.self) { _ in .default }
                .thenFRnProceed(with: SwiftCurrentOnboarding.self) { _ in .default }
                .thenFRnProceed(with: SwiftCurrentOnboarding.self) { _ in .default }
                .thenFRnProceed(with: SwiftCurrentOnboarding.self) { _ in .default }
                .thenFRnProceed(with: SwiftCurrentOnboarding.self) { _ in .default }
                .thenFRnProceed(with: ContentView.self) { .default }

    var body: some Scene {
        WindowGroup {
            if Environment.shouldTest {
                TestView()
            } else {
                WorkflowLauncher(isLaunched: .constant(true), workflow: AnyWorkflow(wf))
//                WorkflowLauncher(isLaunched: .constant(true)) {
//                    thenProceed(with: SwiftCurrentOnboarding.self) {
//                        thenProceed(with: ContentView.self)
//                            .applyModifiers { $0.transition(.slide) }
//                    }.applyModifiers { $0.transition(.slide) }
//                }
                .preferredColorScheme(.dark)
            }
        }
    }
}
