//
//  File.swift
//  SwiftCurrent
//
//  Created by Tyler Thompson on 11/1/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//  

import Foundation
import SwiftCurrent
import SwiftUI

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
class FRThisMetadata: FlowRepresentableMetadata {
    var workflowItem: (() -> AnyWorkflowItem?)?
    public convenience init<F: FlowRepresentable & View>(viewy: F.Type,
                                                         launchStyle: LaunchStyle = .default,
                                                         flowPersistence: @escaping (AnyWorkflow.PassedArgs) -> FlowPersistence) {
        self.init(viewy: viewy,
                  launchStyle: launchStyle,
                  flowPersistence: flowPersistence) { args in
            AnyFlowRepresentable(F.self, args: args)
        }
        workflowItem = {
            AnyWorkflowItem(view: WorkflowItem(F.self))
        }
    }

    public init<FR: FlowRepresentable & View>(viewy: FR.Type,
                                              launchStyle: LaunchStyle = .default,
                                              flowPersistence: @escaping (AnyWorkflow.PassedArgs) -> FlowPersistence,
                                              flowRepresentableFactory: @escaping (AnyWorkflow.PassedArgs) -> AnyFlowRepresentable) {
        super.init(FR.self,
                   launchStyle: launchStyle,
                   flowPersistence: flowPersistence,
                   flowRepresentableFactory: flowRepresentableFactory)
        workflowItem = {
            AnyWorkflowItem(view: WorkflowItem(FR.self))
        }
    }
}
