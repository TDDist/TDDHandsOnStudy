//
//  StringRefinerTests.swift
//  StringRefinerTests
//
//  Created by gwonii on 2021/05/23.
//

import Foundation
import Quick
import Nimble

class StringRefinerTests: QuickSpec {
    override func spec() {
        
        context("불필요한 앞뒤 whiteSpace") {
            
            var sut: StringRefiner!
            let targetString: String = "hello, world"
            beforeEach {
                // given
                sut = TrimWhiteSpaces()
            }
            
            it("앞뒤 X") {
                // when
                let actual = sut.refine("hello, world")
                
                // then
                expect(actual).to(equal(targetString))
            }
            
            it("앞 O") {
                // when
                let actual = sut.refine(" hello, world")
                // then
                expect(actual).to(equal(targetString))
            }
            
            it("뒤 O") {
                // when
                let actual = sut.refine("hello, world  ")
                // then
                expect(actual).to(equal(targetString))
            }
            
            it("앞뒤 O") {
                // when
                let actual = sut.refine("  hello, world   ")
                // then
                expect(actual).to(equal(targetString))
            }
        }
        
        context("중복된 whiteSpace") {
            
            var sut: CreateCommentUseCase!
            let targetString: String = "hello, world"
            
            beforeEach {
                // given
                sut = DefaultCreateCommentUseCase(refiner: CompactWhiteSpaces())
            }
            
            it("") {
                // when
                let actual = sut.invoke(writer: "hcgwonii", content: "hello,    world")
                // then
                expect(actual.content).to(equal(targetString))
            }
        }
        
        context("앞뒤 whiteSpace & 중복 whiteSpace") {
            
            var sut: CreateCommentUseCase!
            let targetString: String = "hello, world"
            
            beforeEach {
                // given
                sut = DefaultCreateCommentUseCase(refiner: CompositeStringRefiner(refiners: [TrimWhiteSpaces(), CompactWhiteSpaces()]))
            }
            
            it("앞뒤 X") {
                // when
                let actual = sut.invoke(writer: "hcgwonii", content: "hello, world")
                
                // then
                expect(actual.content).to(equal(targetString))
            }
            
            it("앞 O") {
                // when
                let actual = sut.invoke(writer: "hcgwonii", content: "    hello, world")
                // then
                expect(actual.content).to(equal(targetString))
            }
            
            it("뒤 O") {
                // when
                let actual = sut.invoke(writer: "hcgwonii", content: "hello, world   ")
                // then
                expect(actual.content).to(equal(targetString))
            }
            
            it("앞뒤 O") {
                // when
                let actual = sut.invoke(writer: "hcgwonii", content: "    hello, world   ")
                // then
                expect(actual.content).to(equal(targetString))
            }
            
            it("앞뒤 O, 중복 O") {
                // when
                let actual = sut.invoke(writer: "hcgwonii", content: "    hello,    world   ")
                // then
                expect(actual.content).to(equal(targetString))
            }
        }
        
    }
}


