//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by Tyler Thompson on 7/14/21.
//
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.

import SwiftUI
import SwiftCurrent_SwiftUI
import SwiftCurrent

struct ContentView: View {
    var body: some View {
        WorkflowLauncher(isLaunched: .constant(true)) {
            thenProceed(with: FRR1.self) {
                thenProceed(with: FRR2.self) {
                    thenProceed(with: FRR3.self)
                }.presentationType(.navigationLink)
                    .persistence(.persistWhenSkipped)
            }.presentationType(.navigationLink)
                .persistence(.persistWhenSkipped)
        }.embedInNavigationView()
    }
}

struct FRR1: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        VStack {
            Text("This is \(String(describing: Self.self))")
            Button("Navigate forward") { proceedInWorkflow() }
        }
    }

    func shouldLoad() -> Bool { false }
}

struct FRR2: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        VStack {
            Text("This is \(String(describing: Self.self))")
            Button("Navigate forward") { proceedInWorkflow() }
        }
    }

    func shouldLoad() -> Bool { false }
}

struct FRR3: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        VStack {
            Text("This is \(String(describing: Self.self))")
            Button("Navigate forward") { proceedInWorkflow() }
        }
    }
}
