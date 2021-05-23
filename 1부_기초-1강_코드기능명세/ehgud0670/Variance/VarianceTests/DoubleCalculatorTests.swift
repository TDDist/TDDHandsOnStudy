//
//  DoubleCalculatorTests.swift
//  VarianceTests
//
//  Created by 스마트스터디_김도형 on 2021/04/25.
//

import XCTest

class DoubleCalculatorTests: XCTestCase {
    let calculator = DoubleCalculator()
    
    func test_calculate_성공메소드() throws {
        // given
        let nums = [1, 2, 3, 4, 5, 6]
        
        // when
        let result = try? calculator.calculate(nums: nums)
        
        // then
        XCTAssertNotNil(result)
        
        let unwrapResult = try XCTUnwrap(result)
        XCTAssertEqual(unwrapResult, 3.5)
    }
    
    func test_calculate_성공메소드_오차범위안에_들어가면_성공() throws {
        // given
        let nums = [2, 2, 5, 7, 6, 10, 7, 8, 9, 1]
        
        // when
        let result = try? calculator.calculate(nums: nums)
        
        // then
        XCTAssertNotNil(result)
        
        let unwrapResult = try XCTUnwrap(result)
        XCTAssertEqual(unwrapResult, 9.78, accuracy: 0.01)
    }
}
