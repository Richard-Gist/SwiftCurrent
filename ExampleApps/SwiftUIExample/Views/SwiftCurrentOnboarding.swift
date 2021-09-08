//
//  SwiftCurrentOnboarding.swift
//  SwiftUIExample
//
//  Created by Tyler Thompson on 8/26/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import SwiftUI
import SwiftCurrent

struct BenefitView: View {
    let image: String
    let title: String
    let description: String

    var body: some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(Color.icon)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(description)
            }
            Spacer()
        }
    }
}

struct SwiftCurrentOnboarding: View, PassthroughFlowRepresentable {
    @AppStorage("OnboardedToSwiftCurrent", store: .fromDI) private var onboardedToSwiftCurrent = false
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
                    Section("General") {
                        BenefitView(image: "point.topleft.down.curvedto.point.bottomright.up",
                                    title: "Isolate your views",
                                    description: "Define your app in workflows so that views remain ignorant of the flow they're in.")
                        BenefitView(image: "arrow.triangle.swap",
                                    title: "Optionally skip screens.",
                                    description: "This screen will only appear once even though the workflow hasn't changed.")
                        BenefitView(image: "arrow.triangle.branch",
                                    title: "Compose workflows together",
                                    description: "Create branching flows by defining new workflows and launching them.")
                        BenefitView(image: "checkmark.seal.fill",
                                    title: "Apple seal of approval (they don't know it)",
                                    description: "We build with Swift, We build how Apple \"wants\" you to so that this works better and longer.  SwiftUI X support.")
                        BenefitView(image: "eye.fill",
                                    title: "See all your workflows in one spot (sort of)",
                                    description: "We surface the complex paths of your app up front. Making it easier to reason through.")
                        BenefitView(image: "switch.2",
                                    title: "Conditional flows",
                                    description: "Make your flows robust and handle ever changing designs. Need a screen sometimes, need a flow for person a and another for person b? We got you covered.")
                    }
                    Section("UI Stuff") {
                        BenefitView(image: "square.stack.3d.down.right",
                                    title: "Manage your view stacks",
                                    description: "[Needs more modals] Workflows can contextually set up navigation views and modals for you.")
                        BenefitView(image: "arrow.left.arrow.right",
                                    title: "Interoperate with UIKit",
                                    description: "Workflows seamlessly interoperate between SwiftUI and UIKit.")
                        BenefitView(image: "laptopcomputer.and.iphone",
                                    title: "Multiple platform support",
                                    description: "iOS ✅, tvOS ✅, macOS ✅, watchOS ✅, ipadOS ✅ 👋🎤")
                        BenefitView(image: "arrow.up.arrow.down",
                                    title: "Easily reorder views",
                                    description: "Changing view orders is as easy as ⌘+⌥+{")
                        BenefitView(image: "arrow.uturn.left.circle",
                                    title: "Reuse views between workflows",
                                    description: "View reuse is so easy when you can drop a view anywhere.")

                    }
                    Section("SwiftUI") {
                        BenefitView(image: "rectangle.3.offgrid",
                                    title: "View swapping",
                                    description: "We make views in your views smarter, so you can get the most with the real estate you got.")
                        BenefitView(image: "iphone.badge.play",
                                    title: "Preview friendly",
                                    description: "Keep using that Preview. We won't interfere.")
                        BenefitView(image: "move.3d",
                                    title: "Animation Friendly",
                                    description: "No AnyViews here, so your animations work how you want them to.")
                    }
                    Section("Design Philosphy") {
                        BenefitView(image: "person.fill.checkmark",
                                    title: "Clear and deliberate API",
                                    description: "The library was built with developers in mind, and making an explicit and clear API. We hope you find it as fun to use as we do")
                        BenefitView(image: "swift",
                                    title: "Works with the latest version of Swift",
                                    description: "From iOS 11 to iOS 15, Swift 5.0 to 5.5, we got you covered")
                        BenefitView(image: "play.fill",
                                    title: "Compile time safety",
                                    description: "We tell you at compile time everything we can so you know things will work")
                        BenefitView(image: "keyboard",
                                    title: "Bye bye Boilerplate",
                                    description: "We extensively take care of the boilerplate. If there's any you have to deal with, it's on our minds how to purge it.")
                        BenefitView(image: "circle.grid.cross.left.fill",
                                    title: "Choices",
                                    description: "We value your ability to choose. We checked our assumptions when designing so you could do the most, with the best.")
                        BenefitView(image: "flowchart",
                                    title: "Remix",
                                    description: "We separated our logic so you can build on top of it. UIKit ✅ SwiftUI ✅ What do you want next? You can make it!")
                        BenefitView(image: "rectangle.3.offgrid.bubble.left",
                                    title: "Talk about it with your PM",
                                    description: "Make discussing flows easier? and when they come up with a new one, you can implement it it so easy.")
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding()
            }

            PrimaryButton(title: "Check It Out!") {
                withAnimation {
                    onboardedToSwiftCurrent = true
                    proceedInWorkflow()
                }
            }
        }
    }

    func shouldLoad() -> Bool {
        !onboardedToSwiftCurrent
    }
}

struct SwiftCurrentOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        SwiftCurrentOnboarding()
            .preferredColorScheme(.dark)
    }
}
