//
//  Variance.swift
//  Variance
//
//  Created by 스마트스터디_김도형 on 2021/04/09.
//

import Foundation

protocol VarianceCalculator {
    associatedtype VarianceType
    
    func calculate(nums: [Int]) throws -> VarianceType
    func avarage(nums: [Int]) -> VarianceType
}
