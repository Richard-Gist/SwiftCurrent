//
//  ChangeEmailViewTests.swift
//  SwiftUIExampleTests
//
//  Created by Tyler Thompson on 7/16/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import XCTest
import ViewInspector

@testable import SwiftCurrent_SwiftUI
@testable import SwiftUIExample

final class ChangeEmailViewTests: XCTestCase {
    func testChangeEmailView() throws {
        let currentUsername = UUID().uuidString
        let exp = ViewHosting.loadView(ChangeEmailView(with: currentUsername)).inspection.inspect { view in
            XCTAssertEqual(try view.find(ViewType.Text.self, traversal: .depthFirst).string(), "Enter new username: ")
            XCTAssertEqual(try view.find(ViewType.TextField.self).labelView().text().string(), "\(currentUsername)")
            XCTAssertNoThrow(try view.find(ViewType.Button.self))
        }
        wait(for: [exp], timeout: TestConstant.timeout)
    }

    func testChangeEmailViewProceedsWithCorrectDataWhenNameChanged() {
        let newUsername = UUID().uuidString
        let proceedCalled = expectation(description: "Proceed called")
        let erased = AnyFlowRepresentableView(type: ChangeEmailView.self, args: .args(""))
        // swiftlint:disable:next force_cast
        var ChangeEmailView = erased.underlyingInstance as! ChangeEmailView
        ChangeEmailView.proceedInWorkflowStorage = {
            XCTAssertEqual($0.extractArgs(defaultValue: nil) as? String, newUsername)
            proceedCalled.fulfill()
        }
        ChangeEmailView._workflowPointer = erased
        let exp = ViewHosting.loadView(ChangeEmailView).inspection.inspect { view in
            XCTAssertEqual(try view.find(ViewType.Text.self, traversal: .depthFirst).string(), "Enter new username: ")
            XCTAssertNoThrow(try view.find(ViewType.TextField.self).setInput(newUsername))
            XCTAssertNoThrow(try view.find(ViewType.Button.self).tap())
        }
        wait(for: [exp, proceedCalled], timeout: TestConstant.timeout)
    }
}
