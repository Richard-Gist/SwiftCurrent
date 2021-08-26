//
//  ChangeUsernameView.swift
//  SwiftUIExample
//
//  Created by Tyler Thompson on 7/15/21.
//
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.

import SwiftUI
import SwiftCurrent

struct ChangeUsernameView: View, FlowRepresentable {
    typealias WorkflowOutput = String

    @State private var currentUsername: String

    let inspection = Inspection<Self>() // ViewInspector
    weak var _workflowPointer: AnyFlowRepresentable?

    init(with username: String) {
        _currentUsername = State(initialValue: username)
    }

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.fill")
                    .foregroundColor(.icon)
                Text("New username: ")
                TextField("\(currentUsername)", text: $currentUsername)
                Spacer()
            }
            .textEntryStyle()
            .padding(.bottom)

            Button {
                withAnimation {
                    proceedInWorkflow(currentUsername)
                }
            } label: {
                Text("SAVE")
                    .primaryButtonStyle()
            }
        }
        .onReceive(inspection.notice) { inspection.visit(self, $0) } // ViewInspector
    }
}


struct ChangeUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeUsernameView(with: "Username input")
            .preferredColorScheme(.dark)
            .background(Color.primaryBackground)
    }
}
