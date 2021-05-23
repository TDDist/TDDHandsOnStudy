//
//  DecimalCalculatorTests.swift
//  VarianceTests
//
//  Created by 스마트스터디_김도형 on 2021/04/10.
//

import XCTest

class DecimalCalculatorTests: XCTestCase {
    let calculator = DecimalCalculator()
    
    func test_calculate_성공메소드() throws {
        // given
        let nums = [1, 2, 3, 4, 5, 6]
        
        // when
        let result = try? calculator.calculate(nums: nums)
        
        // then
        XCTAssertNotNil(result)
        
        let unwrapResult = try XCTUnwrap(result)
        XCTAssertEqual(unwrapResult, Decimal(3.5))
    }
    
    func test_calculate_실패메소드_원소가_하나도_없을때() throws {
        // given
        let empty: [Int] = []
        
        // when
        do {
            _ = try calculator.calculate(nums: empty)
        } catch {
            // then
            let resultError = error as? VarianceError
            XCTAssertNotNil(resultError)
            XCTAssertEqual(resultError!, VarianceError.numsEmptyError)
            XCTAssertEqual(resultError!.errorDescription, "nums 배열의 원소가 비어있으면 안됩니다")
        }
    }
    
    func test_calculate_실패메소드_원소가_하나일때() {
        // given
        let zero = [5]
        
        // when
        do {
            _ = try calculator.calculate(nums: zero)
        } catch {
            // then
            let resultError = error as? VarianceError
            XCTAssertNotNil(resultError)
            XCTAssertEqual(resultError!, VarianceError.numsOnlyOneElementError)
            XCTAssertEqual(resultError!.errorDescription, "nums 배열의 원소가 하나만 있으면 안됩니다. Nan Error 를 일으킵니다.")
        }
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
