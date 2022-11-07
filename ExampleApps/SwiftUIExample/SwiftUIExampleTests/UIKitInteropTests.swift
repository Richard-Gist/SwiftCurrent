//
//  UIKitInteropTests.swift
//  SwiftUIExampleTests
//
//  Created by Tyler Thompson on 8/7/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//
//  swiftlint:disable file_types_order

import XCTest
import UIKit

final class UIKitInteropTests: XCTestCase {
    func testPuttingAUIKitViewThatDoesNotTakeInDataInsideASwiftUIWorkflow() async {
        final class FR1: UIViewController {
            let nextButton = UIButton()
        }
    }
}
