//
//  File.swift
//  SwiftCurrent
//
//  Created by Tyler Thompson on 11/1/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//  

import Foundation
import SwiftUI

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
public struct AnyWorkflowItem: View {
    public typealias Body = AnyView
    public let body: Body
    init<F, W, C>(view: WorkflowItem<F, W, C>) {
        body = AnyView(view)
    }
}
