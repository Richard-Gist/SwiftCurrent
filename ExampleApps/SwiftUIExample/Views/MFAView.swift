//
//  MFAuthenticationView.swift
//  SwiftUIExample
//
//  Created by Tyler Thompson on 7/15/21.
//
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.

import SwiftUI
import SwiftCurrent

struct MFAView: View, PassthroughFlowRepresentable {
    @State var pushSent = false
    @State var enteredCode = ""
    @State var errorMessage: ErrorMessage?
    @State private var id = UUID()

    let inspection = Inspection<Self>() // ViewInspector
    weak var _workflowPointer: AnyFlowRepresentable?

    var body: some View {
        VStack(spacing: 30) {
            if !pushSent {
                Text("This is your friendly MFA Assistant! Tap the button below to pretend to send a push notification and require an account code")
                Button {
                    withAnimation { pushSent = true }
                } label: {
                    Text("Start MFA")
                        .primaryButtonStyle()
                }
            } else {
                Text("Code (enter 1234 to proceed)").font(.title)
                HStack {
                    Image(systemName: "number")
                        .foregroundColor(.icon)
                    TextField("Enter Code", text: $enteredCode)
                    Spacer()
                }
                .textEntryStyle()
                Button {
                    if enteredCode == "1234" {
                        withAnimation {
                            proceedInWorkflow()
                        }
                    } else {
                        errorMessage = ErrorMessage(message: "Invalid code entered, abandoning workflow.")
                    }
                } label: {
                    Text("Submit")
                        .primaryButtonStyle()
                }
            }
        }
        .padding()
        .testableAlert(item: $errorMessage) { message in
            Alert(title: Text(message.message), dismissButton: .default(Text("Ok")) {
                withAnimation {
                    workflow?.abandon()
                }
            })
        }
        .animation(.easeInOut)
        .transition(.opacity)
        .onReceive(inspection.notice) { inspection.visit(self, $0) } // ViewInspector
    }
}

extension MFAView {
    struct ErrorMessage: Identifiable {
        let id = UUID()
        let message: String
    }
}

struct MFAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        MFAView(with: .none)
    }
}
