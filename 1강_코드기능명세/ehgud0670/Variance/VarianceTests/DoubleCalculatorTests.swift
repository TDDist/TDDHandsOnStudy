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
}
