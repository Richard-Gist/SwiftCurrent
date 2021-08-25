//
//  File.swift
//  
//
//  Created by Tyler Thompson on 8/25/21.
//

import SwiftCurrent

public protocol SwiftUIWorkflowPresentable {
    var workflowLaunchStyle: LaunchStyle.SwiftUI.PresentationType { get }
}

extension Never: SwiftUIWorkflowPresentable {
    public var workflowLaunchStyle: LaunchStyle.SwiftUI.PresentationType { .default }
}
