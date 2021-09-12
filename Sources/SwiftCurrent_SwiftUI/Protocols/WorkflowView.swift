//
//  WorkflowView.swift
//  SwiftCurrent_SwiftUI
//
//  Created by Tyler Thompson on 9/11/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import SwiftUI
import SwiftCurrent

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
public protocol WorkflowView: View where FlowRep: FlowRepresentable & View, Wrapped: View, Content: View {
    associatedtype FlowRep
    associatedtype Wrapped
    associatedtype Content
//    associatedtype NewView

//    func applyModifiers<V: View>(@ViewBuilder _ closure: @escaping (FlowRep) -> V) -> NewView
    func persistence(_ persistence: @escaping @autoclosure () -> FlowPersistence) -> Self
    func persistence(_ persistence: @escaping (FlowRep.WorkflowInput) -> FlowPersistence) -> Self
    func presentationType(_ presentationType: @escaping @autoclosure () -> LaunchStyle.SwiftUI.PresentationType) -> Self
}

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
extension WorkflowItem: WorkflowView {
    public typealias FlowRep = F
}
