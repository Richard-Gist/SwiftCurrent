//
//  File.swift
//  SwiftCurrent
//
//  Created by Tyler Thompson on 11/1/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//  

import SwiftCurrent
import SwiftUI

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
extension Workflow {

    /**
     Creates a `Workflow` with a `FlowRepresentable`.
     - Parameter type: a reference to the first `FlowRepresentable`'s concrete type in the workflow.
     - Parameter launchStyle: the `LaunchStyle` the `FlowRepresentable` should use while it's part of this workflow.
     - Parameter flowPersistence: a `FlowPersistence` representing how this item in the workflow should persist.
     */
    public convenience init(viewy: F.Type,
                            launchStyle: LaunchStyle = .default,
                            flowPersistence: @escaping @autoclosure () -> FlowPersistence = .default) where F: View {
        self.init(FRThisMetadata(viewy: viewy,
                                 launchStyle: launchStyle) { _ in flowPersistence() })
    }

    /**
     Adds an item to the workflow; enforces the `FlowRepresentable.WorkflowOutput` of the previous item matches the `FlowRepresentable.WorkflowInput` of this item.
     - Parameter type: a reference to the next `FlowRepresentable`'s concrete type in the workflow.
     - Parameter launchStyle: the `LaunchStyle` the `FlowRepresentable` should use while it's part of this workflow.
     - Parameter flowPersistence: a closure returning a `FlowPersistence` representing how this item in the workflow should persist.
     - Returns: a new workflow with the additional `FlowRepresentable` item.
     */
    public func thenFRnProceed<FR: FlowRepresentable & View>(with type: FR.Type,
                                                             launchStyle: LaunchStyle = .default,
                                                             flowPersistence: @escaping (FR.WorkflowInput) -> FlowPersistence) -> Workflow<FR> where FR.WorkflowInput == AnyWorkflow.PassedArgs {
        let wf = Workflow<FR>(first)
        wf.append(FRThisMetadata(viewy: type,
                                 launchStyle: launchStyle) { flowPersistence($0) })
        return wf
    }
}
