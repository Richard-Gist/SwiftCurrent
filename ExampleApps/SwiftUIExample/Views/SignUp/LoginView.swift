//
//  LoginView.swift
//  LoginView
//
//  Created by Richard Gist on 8/25/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import SwiftUI
import SwiftCurrent
import SwiftCurrent_SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var showSignUp = false
    @State var showPassword = false
    var body: some View {
        GeometryReader { _ in
            VStack {
                Image.logo
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.icon)

                ZStack(alignment: .bottom) {
                    VStack {
                            Text("Welcome!")
                                .titleStyle()

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
                                Button {
                                    showPassword.toggle()
                                } label: {
                                    Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                                        .foregroundColor(.icon)
                                }
                                if showPassword {
                                    TextField("Password", text: $password)
                                        .disableAutocorrection(true)
                                } else {
                                    SecureField("Password", text: $password)
                                        .disableAutocorrection(true)
                                }
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
                        showSignUp = true
                        print("Proceed here")
                    } label: {
                        Text("LOGIN")
                            .primaryButtonStyle()
                    }
                    .offset(y: 25)
                }
            }
        }
        .background(Color.primaryBackground.edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showSignUp) {
            WorkflowLauncher(isLaunched: $showSignUp) {
                thenProceed(with: SignUp.self) {
                    thenProceed(with: Next.self).presentationType(.navigationLink)
                }.presentationType(.navigationLink)
            }.embedInNavigationView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().preferredColorScheme(.dark)
    }
}
