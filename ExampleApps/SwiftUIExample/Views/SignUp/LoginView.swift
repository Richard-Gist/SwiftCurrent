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
            VStack(spacing: 40) {
                Image.logo
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.icon)

                ZStack(alignment: .bottom) {
                    VStack {
                        Text("Welcome!")
                            .titleStyle()

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
                                        .disableAutocorrection(true)
                                } else {
                                    SecureField("Password", text: $password)
                                        .disableAutocorrection(true)
                                }
                            }
                            .textEntryStyle()
                        }

                        HStack {
                            Spacer(minLength: 0)
                        }

                    }
                    .padding()
                    .padding(.bottom, 25)
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
                .padding(.bottom, 27)

                HStack(spacing: 15) {
                    Rectangle()
                        .fill(Color.divider)
                        .frame(height: 1)

                    Text("OR")
                        .foregroundColor(Color.white.opacity(0.8))

                    Rectangle()
                        .fill(Color.divider)
                        .frame(height: 1)
                }
                .padding(.horizontal)

                Button {
                    showSignUp = true
                } label: {
                    Text("Sign Up")
                        .secondaryButtonStyle()
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
        Group {
            LoginView().preferredColorScheme(.dark)
        }
    }
}
