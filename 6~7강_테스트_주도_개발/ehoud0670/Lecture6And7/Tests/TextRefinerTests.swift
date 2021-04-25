//
//  TextRefinerTests.swift
//  Tests
//
//  Created by 스마트스터디_김도형 on 2021/04/25.
//

import XCTest

class TextRefinerTests: XCTestCase {
    func testExecute() {
        let refiner = TextRefiner()
        let result = refiner.execute(args: "hello  world       bravo")
        XCTAssertEqual(result, "hello world bravo")
    }
}
