//
//  TermsAndConditions.swift
//  TermsAndConditions
//
//  Created by Richard Gist on 8/25/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import SwiftUI
import SwiftCurrent

struct TermsAndConditions: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        GeometryReader { _ in
            VStack {
                HStack {
                    Image(systemName: "document")
                    VStack {
                        Text("Terms of Service")
                        Text("Last Update 08/25/2021")
                    }
                }

            }
        }.background(Color.primaryBackground.edgesIgnoringSafeArea(.all))
    }
}

struct TermsAndConditions_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditions().preferredColorScheme(.dark)
    }
}
