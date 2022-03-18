//
//  JamesTests.swift
//  JamesTests
//
//  Created by Ionel Lescai on 12.03.2022.
//

import XCTest
@testable import James
import Structures

class JamesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodingFile() throws {
        print(projectRoot)
        let transactions: [Transaction] = try .fromFile(path: URL(fileURLWithPath: projectRoot.appending("/output.json")))
        XCTAssertTrue(transactions.count > 0)
    }
}

var projectRoot: String {
    let packageRootPath =
        URL(fileURLWithPath: #file)
        .pathComponents
        .prefix(while: { $0 != "JamesTests" })
        .dropLast()
        .joined(separator: "/")
        .dropFirst()
    return String(packageRootPath)
}
