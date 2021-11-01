//
//  File.swift
//  SwiftCurrent
//
//  Created by Richard Gist on 11/1/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//  

import Foundation
import SwiftUI

import SwiftCurrent
import SwiftCurrent_SwiftUI

import XCTest

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
final class SpikeTests: XCTestCase, View {
    func testSomething() {
        let workflowAsAList = [FR1.self, FR2.self, FR3.self] as [Any]

        let workflowItem = thenProceed(with: FR1.self) {
            thenProceed(with: FR2.self)
        }

        let workflowWithList = thenProceed(with: workflowAsAList[0] as! FR1.Type) {
            thenProceed(with: workflowAsAList[1] as! FR2.Type)
        }

        let workflowItemLast = thenProceed(with: FR3.self)
        let workflowItemSecond = thenProceed(with: FR2.self, nextItem: { workflowItemLast }) // would auto closure do anything?
        let workflowItemFirst = thenProceed(with: FR1.self, nextItem: { workflowItemSecond })
        let launcher = WorkflowLauncher(isLaunched: .constant(true), content: { workflowItemFirst })

        let workflowItemLastS = thenProceed(with: workflowAsAList[2] as! FR3.Type)
        let workflowItemSecondS = thenProceed(with: workflowAsAList[1] as! FR2.Type, nextItem: { workflowItemLast }) // would auto closure do anything?
        let workflowItemFirstS = thenProceed(with: workflowAsAList[0] as! FR1.Type, nextItem: { workflowItemSecond })
        let launcherS = WorkflowLauncher(isLaunched: .constant(true), content: { workflowItemFirst })

//        let workflowWithClosureThing = thenProceed(with: FR1.self, nextItem: replacementThingy())
    }

//    func replacementThingy() -> WorkflowItem<<#F: FlowRepresentable & View#>, <#Wrapped: View#>, <#Content: View#>> {
//        thenProceed(with: FR2.self)
//    }

    func testConvertingWorkflowMetaDataToWorkflowItemMaybe() {
        let metaData = FlowRepresentableMetadata(FR1.self, flowPersistence: { _ in .default })
    }
}

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
class SuperFR {
    static let fr1 = FR1.self
    static let fr2 = FR2.self
    static let fr3 = FR3.self
}

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
struct FR1: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        VStack {
            Text("This is \(String(describing: Self.self))")
            Button("Navigate forward") { proceedInWorkflow() }
        }
    }
}

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
struct FR2: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        VStack {
            Text("This is \(String(describing: Self.self))")
            Button("Navigate forward") { proceedInWorkflow() }
        }
    }
}

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
struct FR3: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        VStack {
            Text("This is \(String(describing: Self.self))")
            Button("Navigate forward") { proceedInWorkflow() }
        }
    }
}







// MARK: NOT REAL IDEAS BUT THOUGHTS THAT POPPED INTO MY HEAD

// What if we had something that was known like FR1 -> FR100 and each one had static programmable body that you could set.
