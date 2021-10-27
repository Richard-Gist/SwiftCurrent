//
//  ChangePasswordViewTests.swift
//  SwiftUIExampleTests
//
//  Created by Tyler Thompson on 7/15/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import XCTest
import ViewInspector
import SwiftUI

@testable import SwiftCurrent_SwiftUI
@testable import SwiftUIExample

final class ChangePasswordViewTests: XCTestCase, View {
    func testChangePasswordView() throws {
        let currentPassword = UUID().uuidString
        let exp = ViewHosting.loadView(ChangePasswordView(with: currentPassword)).inspection.inspect { view in
            XCTAssertEqual(view.findAll(PasswordField.self).count, 3)
            XCTAssertNoThrow(try view.find(ViewType.Button.self))
        }
        wait(for: [exp], timeout: TestConstant.timeout)
    }

    func testChangePasswordProceeds_IfAllInformationIsCorrect() throws {
        let currentPassword = UUID().uuidString
        let onFinish = expectation(description: "onFinish called")
        let exp = ViewHosting.loadView(WorkflowLauncher(isLaunched: .constant(true), startingArgs: currentPassword) {
            thenProceed(with: ChangePasswordView.self)
        }
        .onFinish { _ in onFinish.fulfill() }).inspection.inspect { view in
            XCTAssertNoThrow(try view.find(ViewType.SecureField.self).setInput(currentPassword))
            XCTAssertNoThrow(try view.find(ViewType.SecureField.self, skipFound: 1).setInput("asdfF1"))
            XCTAssertNoThrow(try view.find(ViewType.SecureField.self, skipFound: 2).setInput("asdfF1"))
            XCTAssertNoThrow(try view.find(ViewType.Button.self).tap())
        }
        wait(for: [exp, onFinish], timeout: TestConstant.timeout)
    }

    func testErrorsDoNotShowUp_IfFormWasNotSubmitted() throws {
        let currentPassword = UUID().uuidString
        let exp = ViewHosting.loadView(ChangePasswordView(with: currentPassword)).inspection.inspect { view in
            XCTAssertNoThrow(try view.find(ViewType.SecureField.self).setInput(currentPassword))
            XCTAssertNoThrow(try view.find(ViewType.SecureField.self, skipFound: 1).setInput("asdfF1"))
            XCTAssertNoThrow(try view.find(ViewType.SecureField.self, skipFound: 2).setInput("asdfF1"))
            XCTAssertNoThrow(try view.find(ViewType.Button.self))
        }
        wait(for: [exp], timeout: TestConstant.timeout)
    }

    func testIncorrectOldPassword_PrintsError() throws {
        let currentPassword = UUID().uuidString
        let exp = ViewHosting.loadView(ChangePasswordView(with: currentPassword)).inspection.inspect { view in
            XCTAssertNoThrow(try view.find(ViewType.SecureField.self).setInput("WRONG"))
            XCTAssertNoThrow(try view.find(ViewType.Button.self).tap())
            XCTAssert(try view.vStack().text(0).string().contains("Old password does not match records"))
        }
        wait(for: [exp], timeout: TestConstant.timeout)
    }

    func testPasswordsNotMatching_PrintsError() throws {
        let currentPassword = UUID().uuidString
        let exp = ViewHosting.loadView(ChangePasswordView(with: currentPassword)).inspection.inspect { view in
            XCTAssertNoThrow(try view.find(ViewType.SecureField.self).setInput(currentPassword))
            XCTAssertNoThrow(try view.find(ViewType.SecureField.self, skipFound: 1).setInput(UUID().uuidString))
            XCTAssertNoThrow(try view.find(ViewType.SecureField.self, skipFound: 2).setInput(UUID().uuidString))
            XCTAssertNoThrow(try view.find(ViewType.Button.self).tap())
            XCTAssert(try view.vStack().text(0).string().contains("New password and confirmation password do not match"))
        }
        wait(for: [exp], timeout: TestConstant.timeout)
    }

    func testPasswordsNotHavingUppercase_PrintsError() throws {
        let currentPassword = UUID().uuidString
        let exp = ViewHosting.loadView(ChangePasswordView(with: currentPassword)).inspection.inspect { view in
            XCTAssertNoThrow(try view.find(ViewType.SecureField.self, skipFound: 1).setInput("asdf1"))
            XCTAssertNoThrow(try view.find(ViewType.Button.self).tap())
            XCTAssert(try view.vStack().text(0).string().contains("Password must contain at least one uppercase character"))
        }
        wait(for: [exp], timeout: TestConstant.timeout)
    }

    func testPasswordsNotHavingNumber_PrintsError() throws {
        let currentPassword = UUID().uuidString
        let exp = ViewHosting.loadView(ChangePasswordView(with: currentPassword)).inspection.inspect { view in
            XCTAssertNoThrow(try view.find(ViewType.SecureField.self, skipFound: 1).setInput("asdfF"))
            XCTAssertNoThrow(try view.find(ViewType.Button.self).tap())
            XCTAssert(try view.vStack().text(0).string().contains("Password must contain at least one number"))
        }
        wait(for: [exp], timeout: TestConstant.timeout)
    }
}
