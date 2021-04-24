//
//  TextRefiner_Improved_Tests.swift
//  TextRefiner_Improved_Tests
//
//  Created by gwonii on 2021/04/24.
//

import XCTest

import Quick
import Nimble

class TextRefiner_Improved_Tests: XCTestCase {
    
    let sut: TextRefiner_Improved = TextRefiner_Improved()

    func testRefine_twoSpace() throws {
        // given
        let targetText: String = "hello  world"
        
        // when
        let actual = sut.refine(text: targetText)
        
        // then
        expect(actual).to(equal("hello world"))
    }
    
    func testRefine_loop_improved() throws {
        // given
        let targetTexts: [String] = [
            "hello world",          // one space
            "hello  world",         // two space
            "hello   world",        // three space
            "hello    world",       // four space
            "hello     world",      // five space
            "hello      world",     // six space
            "hello       world"    // seven space
        ]
        
        // when
        let actuals: [String] = targetTexts.map { (targetText) -> String in
            return sut.refine(text: targetText)
        }
        
        // then
        for (index, actual) in actuals.enumerated() {
            expect(actual).to(equal("hello world"), description: "failed index: \(index + 1)번째")
        }
    }
    
    func testRefine_tap() throws {
        // given
        let targetTexts: [String] = [
            "hello\t world",
            "hello\tworld"
        ]
        
        // when
        let actuals: [String] = targetTexts.map { (targetText) -> String in
            return sut.refine(text: targetText)
        }
        
        // then
        for (index, actual) in actuals.enumerated() {
            expect(actual).to(equal("hello world"), description: "failed index: \(index + 1)번째")
        }
    }
    
    func testRefine_random_text() throws {
        // given
        let allCharacters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomSize: Int = Int.random(in: 0..<allCharacters.count)
        let randomText: String = String(
            (0..<randomSize)
                .compactMap { _ in allCharacters.randomElement() }
        )
        let targetText: String = "hello \(randomText)"
        let expected: String = "hello \(String(repeating: "*", count: randomSize))"
        
        // when
        let actual: String = sut.refine(text: targetText, bannedWord: randomText)
        
        // then
        expect(actual).to(equal(expected))
    }
}
