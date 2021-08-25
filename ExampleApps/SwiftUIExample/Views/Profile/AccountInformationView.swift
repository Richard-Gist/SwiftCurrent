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
            HStack {
                if !usernameWorkflowLaunched {
                    HStack {
                        Image(systemName: "person")
                        Text("Username: ")
                        Text(username)
                        Spacer()
                        Button {
                            withAnimation {
                                usernameWorkflowLaunched = true
                            }
                        } label: {
                            Image(systemName: "pencil")
                        }
                    }
                    .textEntryStyle()
                }
                    WorkflowLauncher(isLaunched: $usernameWorkflowLaunched.animation(), startingArgs: username) {
                        thenProceed(with: MFAView.self) {
                            thenProceed(with: ChangeUsernameView.self).presentationType(.modal)
                        }
                    }.onFinish {
                        guard case .args(let newUsername as String) = $0 else { return }
                        username = newUsername
                        withAnimation {
                            usernameWorkflowLaunched = false
                        }
                    }

            }

            if !passwordWorkflowLaunched {
                HStack {
                    Image(systemName: "lock")
                    Text("Password: ")
                    SecureField(text: $password) { EmptyView() }.disabled(true)
                    Spacer()
                    Button{
                        withAnimation {
                            passwordWorkflowLaunched = true
                        }
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
                .textEntryStyle()
            } else {
                WorkflowLauncher(isLaunched: $passwordWorkflowLaunched.animation(), startingArgs: password) {
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

struct temp: PreviewProvider {
    static var previews: some View {
        AccountInformationView()
            .preferredColorScheme(.dark)
            .background(Color.primaryBackground)

    }
}
