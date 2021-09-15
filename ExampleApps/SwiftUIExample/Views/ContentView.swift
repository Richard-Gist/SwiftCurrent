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
    let inspection = Inspection<Self>() // ViewInspector
    enum Tab {
        case map
        case qr
        case profile
    }
    @State var selectedTab: Tab = .map

    var body: some View {
        WorkflowLauncher(isLaunched: .constant(true)) {
            thenProceed(with: FR1.self) {
                thenProceed(with: FRR2.self) {
                    thenProceed(with: FR3.self)
                }
                .persistence(.persistWhenSkipped)
                .presentationType(.navigationLink)
            }
            .persistence(.persistWhenSkipped)
            .presentationType(.navigationLink)
        }
        .embedInNavigationView()
    }
}

struct FRR1: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        FR1()
    }

    func shouldLoad() -> Bool { false }
}

struct FRR2: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        FR2()
    }

    func shouldLoad() -> Bool { false }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
