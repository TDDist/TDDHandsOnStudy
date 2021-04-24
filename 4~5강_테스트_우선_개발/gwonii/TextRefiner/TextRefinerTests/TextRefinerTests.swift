//
//  TextRefinerTests.swift
//  TextRefinerTests
//
//  Created by gwonii on 2021/04/24.
//

import XCTest
import Nimble
import Quick

class TextRefinerTests: XCTestCase {
    
    let sut: TextRefiner = TextRefiner()
    
    func testRefine_twoSpace() throws {
        // given
        let targetText: String = "hello  world"
        
        // when
        let actual = sut.refine(text: targetText)
        
        // then
        expect(actual).to(equal("hello world"))
    }
    
    func testRefine_threeSpace() throws {
        // given
        let targetText: String = "hello   world"
        
        // when
        let actual = sut.refine(text: targetText)
        
        // then
        expect(actual).to(equal("hello world"))
    }
    
    func testRefine_loop() throws {
        // given
        let targetTexts: [String] = [
            "hello world",      // one space
            "hello  world",     // two space
            "hello   world",    // three space
            "hello    world",   // four space
        ]
        
        // when
        let actuals: [String] = targetTexts.map { (targetText) -> String in
            return sut.refine(text: targetText)
        }
        
        // then
        // forEach를 통해 테스트 코드를 줄일 수 있지만
        // 어떤 targetText에서 에러가 났는지 알 수 없다.
        // 테스트 품질로 따졌을 땐, 훨씬 안좋아졌다.
        actuals.forEach { (actual) in
            expect(actual).to(equal("hello world"))
        }
    }
    
    func testRefine_loop_improved() throws {
        // given
        let targetTexts: [String] = [
            "hello world",      // one space
            "hello  world",     // two space
            "hello   world",    // three space
            "hello    world",   // four space
        ]
        
        let actuals: [String] = targetTexts.map { (targetText) -> String in
            return sut.refine(text: targetText)
        }
        
        // for문과 enumerated를 이용해서 전체 테스트를 진행하면서 실패된 케이스들을 전부 확인할 수 있다.
        // XCTest나 Nimble에는 Parameterize Test는 제공하지 않는다.
        for (index, actual) in actuals.enumerated() {
            expect(actual).to(equal("hello world"), description: "failed index: \(index + 1)번째")
        }
    }
    
    
}
