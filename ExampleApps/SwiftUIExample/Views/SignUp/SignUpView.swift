//
//  SignUp.swift
//  SignUp
//
//  Created by Tyler Thompson on 8/25/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import SwiftUI
import SwiftCurrent

struct SignUp: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false

    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 20) {
                Text("We just need a little bit of information to get you started.")
                    .multilineTextAlignment(.center)

                VStack(spacing: 15) {
                    HStack(spacing: 15) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.icon)

                        TextField("Email Address", text: $email)
                            .keyboardType(.emailAddress)
                    }
                    .textEntryStyle()

                    HStack(spacing: 15) {
                        Button {
                            showPassword.toggle()
                        } label: {
                            Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                                .foregroundColor(.icon)
                        }
                        if showPassword {
                            TextField("Password", text: $password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        } else {
                            SecureField("Password", text: $password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                    }
                    .textEntryStyle()

                    HStack(spacing: 15) {
                        Button {
                            showConfirmPassword.toggle()
                        } label: {
                            Image(systemName: showConfirmPassword ? "eye.fill" : "eye.slash.fill")
                                .foregroundColor(.icon)
                        }
                        if showConfirmPassword {
                            TextField("Confirm Password", text: $confirmPassword)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        } else {
                            SecureField("Confirm Password", text: $confirmPassword)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                    }
                    .textEntryStyle()
                }

                HStack {
                    Spacer(minLength: 0)
                }

                Button {
                    proceedInWorkflow()
                } label: {
                    Text("Next")
                        .primaryButtonStyle()
                }
            }
            .padding()
            .padding(.bottom, 5)
            .padding(.horizontal, 20)
            .background(Color.card)
            .cornerRadius(50)
            .padding(.top, 30)
        }
        .background(Color.primaryBackground.edgesIgnoringSafeArea(.all))
        .navigationTitle("Sign Up!")
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUp().preferredColorScheme(.dark)
        }
    }
}
