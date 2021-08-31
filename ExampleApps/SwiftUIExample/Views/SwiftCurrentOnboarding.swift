//
//  SwiftCurrentOnboarding.swift
//  SwiftUIExample
//
//  Created by Tyler Thompson on 8/26/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import SwiftUI
import SwiftCurrent

struct SwiftCurrentOnboarding: View, PassthroughFlowRepresentable {
    weak var _workflowPointer: AnyFlowRepresentable?
    var body: some View {
        VStack {
            Image.socialMediaIcon
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
            Text("Value added text thing")
                .titleStyle()
            
            ScrollView {
                VStack(spacing: 50) {
                    HStack {
                        Image(systemName: "point.topleft.down.curvedto.point.bottomright.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.icon)
                        VStack(alignment: .leading) {
                            Text("Isolate your views")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Define your app in workflows so that views remain ignorant of the flow they're in.")
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "arrow.triangle.swap")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.icon)
                        VStack(alignment: .leading) {
                            Text("Optionally skip screens.")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("This screen will only appear once even though the workflow hasn't changed.")
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "arrow.triangle.branch")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.icon)
                        VStack(alignment: .leading) {
                            Text("Compose workflows together")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Create branching flows by defining new workflows and launching them.")
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "square.stack.3d.down.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.icon)
                        VStack(alignment: .leading) {
                            Text("Manage your view stacks")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Workflows can contextually set up navigation views and modals for you.")
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "arrow.left.arrow.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.icon)
                        VStack(alignment: .leading) {
                            Text("Interoperate with UIKit")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Workflows seamlessly interoperate between SwiftUI and UIKit.")
                        }
                        Spacer()
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                
            }

            PrimaryButton(title: "Check It Out!") {
                withAnimation {
                    proceedInWorkflow()
                }
            }
        }
    }
}

struct SwiftCurrentOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        SwiftCurrentOnboarding()
            .preferredColorScheme(.dark)
    }
}
