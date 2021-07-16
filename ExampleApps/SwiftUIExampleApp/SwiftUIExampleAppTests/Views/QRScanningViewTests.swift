//
//  QRScanningViewTests.swift
//  SwiftUIExampleAppTests
//
//  Created by Tyler Thompson on 7/15/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import XCTest
import SwiftUI
import Swinject
import ViewInspector
import CodeScanner

@testable import SwiftCurrent_SwiftUI // 🤮 it sucks that this is necessary
@testable import SwiftUIExampleApp

final class QRScanningViewTests: XCTestCase {
    func testQRScanningView() throws {
        let code = UUID().uuidString
        let exp = ViewHosting.loadView(QRScannerFeatureView()).inspection.inspect { viewUnderTest in
            XCTAssertEqual(try viewUnderTest.view(CodeScannerView.self).actualView().codeTypes, [.qr])
            XCTAssertNoThrow(try viewUnderTest.actualView().scannedCode = .init(data: code))
            XCTAssertEqual(try viewUnderTest.view(CodeScannerView.self).sheet().find(ViewType.Text.self).string(), "SCANNED DATA: \(code)")
        }
        wait(for: [exp], timeout: 0.5)
    }
}
