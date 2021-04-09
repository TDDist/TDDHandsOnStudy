//
//  TextRefinerTests.swift
//  TextRefinerTests
//
//  Created by 스마트스터디_김도형 on 2021/04/10.
//

import XCTest

class TextRefinerTests: XCTestCase {
    func test_execute_성공메서드_중간에_홀수_짝수_모두_있는경우() {
        // given
        let textRefiner = TextRefiner()
        
        // when
        let result = textRefiner.execute(texts: "hello  world   bravo")
        
        // then
        XCTAssertEqual(result, "hello world bravo")
    }
    
    func test_execute_성공메서드_끝에도_빈칸_있는_경우() {
        // given
        let textRefiner = TextRefiner()
        
        // when
        let result = textRefiner.execute(texts: "hello           world       ")
        
        // then
        XCTAssertEqual(result, "hello world")
    }
    
    func test_execute_성공메서드_for문_돌리기() {
        let textRefiner = TextRefiner()
        for texts in ["hello      world","hello           world       "] {
            let result = textRefiner.execute(texts: texts)
            XCTAssertEqual(result, "hello world")
        }
    }
}
