//
//  DecimalCalculator.swift
//  Variance
//
//  Created by 스마트스터디_김도형 on 2021/04/10.
//

import Foundation

class DecimalCalculator: VarianceCalculator {
    typealias VarianceType = Decimal
    
    func calculate(nums: [Int]) throws -> Decimal {
        guard nums.count != 0 else {
            throw VarianceError.numsEmptyError
        }
        guard nums.count != 1 else {
            throw VarianceError.numsOnlyOneElementError
        }
        
        let mean: Decimal = avarage(nums: nums)
        var fraction = Decimal(0)
        for element in nums {
            let curElement: Decimal = Decimal(element)
            fraction += pow(curElement - mean, 2)
        }
        
        let denominator: Decimal = Decimal(nums.count - 1)
        return fraction / denominator
    }
    
    func avarage(nums: [Int]) -> Decimal {
        let sumDecimal = Decimal(sum(nums: nums))
        let nDecimal = Decimal(nums.count)
        return sumDecimal / nDecimal
    }
    
    private func sum(nums: [Int]) -> Int {
        return nums.reduce(0, +)
    }
}
