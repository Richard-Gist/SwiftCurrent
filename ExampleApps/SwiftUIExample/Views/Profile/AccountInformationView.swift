//
//  AccountInformationView.swift
//  SwiftUIExample
//
//  Created by Tyler Thompson on 7/15/21.
//
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.

import SwiftUI
import SwiftCurrent
import SwiftCurrent_SwiftUI

struct AccountInformationView: View, FlowRepresentable {
    @State var password = "supersecure"
    @State private var username = "changeme"
    @State private var usernameWorkflowLaunched = false
    @State private var passwordWorkflowLaunched = false

    let inspection = Inspection<Self>() // ViewInspector
    weak var _workflowPointer: AnyFlowRepresentable?

    var body: some View {
        VStack(alignment: .leading, spacing: 25) { // swiftlint:disable:this closure_body_length
            if !usernameWorkflowLaunched {
                HStack {
                    Text("Username: \(username)")
                    Spacer()
                    Button("Change Username") {
                        usernameWorkflowLaunched = true
                    }
                }
            } else {
                WorkflowLauncher(isLaunched: $usernameWorkflowLaunched, startingArgs: username) {
                    thenProceed(with: MFAView.self) {
                        thenProceed(with: ChangeUsernameView.self).presentationType(.modal)
                    }
                }.onFinish {
                    guard case .args(let newUsername as String) = $0 else { return }
                    username = newUsername
                    usernameWorkflowLaunched = false
                }
            }
            if !passwordWorkflowLaunched {
                Button("Change Password") {
                    passwordWorkflowLaunched = true
                }
            } else {
                WorkflowLauncher(isLaunched: $passwordWorkflowLaunched, startingArgs: password) {
                    thenProceed(with: MFAView.self) {
                        thenProceed(with: ChangePasswordView.self)
                    }
                }.onFinish {
                    guard case .args(let newPassword as String) = $0 else { return }
                    password = newPassword
                    passwordWorkflowLaunched = false
                }
            }
        }.onReceive(inspection.notice) { inspection.visit(self, $0) } // ViewInspector
    }
}
