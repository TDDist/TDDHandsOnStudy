//
//  FloatCalculator.swift
//  Variance
//
//  Created by 스마트스터디_김도형 on 2021/04/25.
//

import Foundation

class FloatCalculator: VarianceCalculatable {
    typealias VarianceType = Float
    
    func calculate(nums: [Int]) throws -> Float {
        guard nums.count != 0 else {
            throw VarianceError.numsEmptyError
        }
        guard nums.count != 1 else {
            throw VarianceError.numsOnlyOneElementError
        }
        
        let mean: Float = avarage(nums: nums)
        var fraction: Float = 0.0
        for element in nums {
            let curElement = Float(element)
            fraction += pow(curElement - mean, 2)
        }
        
        return fraction / Float(nums.count - 1)
    }
    
    func avarage(nums: [Int]) -> Float {
        return Float(sum(nums: nums)) / Float(nums.count)
    }
    
    private func sum(nums: [Int]) -> Int {
        return nums.reduce(0, +)
    }
}
