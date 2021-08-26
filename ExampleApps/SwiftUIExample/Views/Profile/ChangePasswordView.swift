//
//  ChangePasswordView.swift
//  SwiftUIExample
//
//  Created by Tyler Thompson on 7/15/21.
//
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.

import SwiftUI
import SwiftCurrent

struct ChangePasswordView: View, FlowRepresentable {
    typealias WorkflowOutput = String
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmNewPassword: String = ""
    @State private var submitted = false
    @State private var errors = [String]()

    let inspection = Inspection<Self>() // ViewInspector

    private let currentPassword: String

    weak var _workflowPointer: AnyFlowRepresentable?

    init(with password: String) {
        currentPassword = password
    }

    var body: some View {
        VStack {
            if !errors.isEmpty {
                Text(errors.joined(separator: "\n")).foregroundColor(Color.red)
                    .transition(.scale)
            }

            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.icon)
                TextField("Old Password", text: $oldPassword)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                Spacer()
            }
            .textEntryStyle()

            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(.icon)
                TextField("New Password", text: $newPassword)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                Spacer()
            }
            .textEntryStyle()

            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(.icon)
                TextField("Confirm New Password", text: $confirmNewPassword)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                Spacer()
            }
            .textEntryStyle()
            .padding(.bottom)

            Button {
                submitted = true
                validatePassword(newPassword)
                if errors.isEmpty {
                    withAnimation {
                        proceedInWorkflow(newPassword)
                    }
                }
            } label: {
                Text("SAVE")
                    .primaryButtonStyle()
            }
        }
        .onChange(of: oldPassword, perform: validateOldPassword)
        .onChange(of: newPassword, perform: validatePassword)
        .onChange(of: confirmNewPassword, perform: validatePassword)
        .onReceive(inspection.notice) { inspection.visit(self, $0) } // ViewInspector
    }

    private func validateOldPassword(_ password: String) {
        withAnimation {
            errors.removeAll()
            guard submitted else { return }
            if password != currentPassword {
                errors.append("Old password does not match records")
            }
        }
    }

    private func validatePassword(_ password: String) {
        guard submitted else { return }
        withAnimation {
            validateOldPassword(oldPassword)
            switch password {
            case _ where !password.contains { $0.isUppercase }:
                errors.append("Password must contain at least one uppercase character")
            case _ where !password.contains { $0.isNumber }:
                errors.append("Password must contain at least one number")
            default: break
            }

            if newPassword != confirmNewPassword {
                errors.append("New password and confirmation password do not match")
            }
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(with: "Username input")
            .preferredColorScheme(.dark)
            .background(Color.primaryBackground)
    }
}
