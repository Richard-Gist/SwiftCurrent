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
    @State var email = ""
    @State var password = ""

    var body: some View {
        GeometryReader { _ in
            VStack {
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 60, height: 60)

                ZStack(alignment: .bottom) {
                    VStack {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)

                        VStack {
                            HStack(spacing: 15) {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(.icon)

                                TextField("Email Address", text: $email)
                                    .keyboardType(.emailAddress)
                            }

                            Divider().background(Color.divider)
                        }
                        .padding(.horizontal)
                        .padding(.top, 40)

                        VStack {
                            HStack(spacing: 15) {
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(.icon)

                                SecureField("Password", text: $password)
                                    .disableAutocorrection(true)
                            }

                            Divider().background(Color.divider)
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)

                        HStack {
                            Spacer(minLength: 0)
                        }

                    }.padding()
                        .padding(.bottom, 65)
                        .background(Color.card)
                        .cornerRadius(35)
                        .padding(.horizontal, 20)

                    Button {
                        proceedInWorkflow()
                    } label: {
                        Text("Next")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .padding(.horizontal, 50)
                            .background(Color.primaryButton)
                            .clipShape(Capsule())
                            .shadow(color: .white.opacity(0.1), radius: 5, x: 0, y: 5)
                    }
                    .offset(y: 25)
                }
            }
        }
        .background(Color.primaryBackground.edgesIgnoringSafeArea(.all))
    }
}

struct Next: View, FlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        Text("I AM NEXT!")
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
