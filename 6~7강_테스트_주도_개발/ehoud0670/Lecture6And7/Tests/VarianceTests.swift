//
//  Tests.swift
//  Tests
//
//  Created by 스마트스터디_김도형 on 2021/04/25.
//

import XCTest

class VarianceTests: XCTestCase {
    func testCalculate_인수_개수가_0일때() {
        let variance = Variance()
        
        do {
            _ = try variance.calculate(args: [])
        } catch {
            XCTAssertEqual(error.localizedDescription, "입력된 데이터가 없습니다")
        }
    }
    
    func testCalculate_인수_개수가_1일때() {
        let variance = Variance()
        
        do {
            _ = try variance.calculate(args: ["1"])
        } catch {
            XCTAssertEqual(error.localizedDescription, "데이터가 부족해 분산을 계산할 수 없습니다. 2개 이상의 데이터를 입력해 주세요.")
        }
    }
    
    func testCalculate_성공케이스() throws {
        let variance = Variance()
        
        let result = try? variance.calculate(args: ["1",
        "2", "3", "4", "5", "6"])
        
        let unwrapResult = try XCTUnwrap(result)
        XCTAssertEqual(unwrapResult, 3.5)
    }
}
