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
    
    func testExecute_탭포함() {
        let refiner = TextRefiner()
        let result = refiner.execute(args: "hello  world\t")
        XCTAssertEqual(result, "hello world")
    }
    
    func testExecute_bannedWords_포함() {
        let refiner = TextRefiner()
        let result = refiner.execute(args: "kimdo    jason    hello    words      ", bannedWords: ["kimdo", "jason"])
        XCTAssertEqual(result, "***** ***** hello words")
    }
}
