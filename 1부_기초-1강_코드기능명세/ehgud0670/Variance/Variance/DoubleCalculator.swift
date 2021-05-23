//
//  DoubleCalculator.swift
//  Variance
//
//  Created by 스마트스터디_김도형 on 2021/04/25.
//

import Foundation

class DoubleCalculator: VarianceCalculatable {
    typealias VarianceType = Double
    
    func calculate(nums: [Int]) throws -> Double {
        guard nums.count != 0 else {
            throw VarianceError.numsEmptyError
        }
        guard nums.count != 1 else {
            throw VarianceError.numsOnlyOneElementError
        }
        
        let mean: Double = avarage(nums: nums)
        var fraction: Double = 0.0
        for element in nums {
            let curElement = Double(element)
            fraction += pow(curElement - mean, 2)
        }
        
        return fraction / Double(nums.count - 1)
    }
    
    func avarage(nums: [Int]) -> Double {
        return Double(sum(nums: nums)) / Double(nums.count)
    }
    
    private func sum(nums: [Int]) -> Int {
        return nums.reduce(0, +)
    }
}
