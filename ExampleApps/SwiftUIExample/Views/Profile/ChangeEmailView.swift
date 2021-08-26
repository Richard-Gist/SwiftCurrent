//
//  ChangeEmailView.swift
//  SwiftUIExample
//
//  Created by Tyler Thompson on 7/15/21.
//
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.

import SwiftUI
import SwiftCurrent

struct ChangeEmailView: View, FlowRepresentable {
    typealias WorkflowOutput = String

    @State private var currentEmail: String

    let inspection = Inspection<Self>() // ViewInspector
    weak var _workflowPointer: AnyFlowRepresentable?

    init(with email: String) {
        _currentEmail = State(initialValue: email)
    }

    var body: some View {
        VStack {
            HStack {
                Image.account
                    .foregroundColor(.icon)
                Text("New email: ")
                TextField("\(currentEmail)", text: $currentEmail)
                    .keyboardType(.emailAddress)
                Spacer()
            }
            .textEntryStyle()
            .padding(.bottom)

            Button {
                withAnimation {
                    proceedInWorkflow(currentEmail)
                }
            } label: {
                Text("SAVE")
                    .primaryButtonStyle()
            }
        }
        .onReceive(inspection.notice) { inspection.visit(self, $0) } // ViewInspector
    }
}


struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView(with: "Email input")
            .preferredColorScheme(.dark)
            .background(Color.primaryBackground)
    }
}
