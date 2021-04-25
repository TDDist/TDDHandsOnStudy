//
//  Variance.swift
//  Lecture6And7
//
//  Created by 스마트스터디_김도형 on 2021/04/25.
//

import Foundation

class Variance {
    enum VarianceError: LocalizedError {
        case noInput
        case oneInput
        
        var errorDescription: String? {
            switch self {
            case .noInput:
                return "입력된 데이터가 없습니다"
            case .oneInput:
                return "데이터가 부족해 분산을 계산할 수 없습니다. 2개 이상의 데이터를 입력해 주세요."
            }
        }
    }
    
    func calculate(args: [String]) throws -> Double {
        try throwErrorIfNotValidate(count: args.count)
        
        let source = parsing(args)
        let mean = calculateMean(parsing(args))
        let sumOfSquares = calculateSumOfSquares(source: source, mean: mean)
        return sumOfSquares / Double(source.count - 1)
    }
    
    private func throwErrorIfNotValidate(count: Int) throws {
        if count == 0 { throw VarianceError.noInput }
        if count == 1 { throw VarianceError.oneInput }
    }
    
    private func parsing(_ arguments: [String]) -> [Double] {
        return arguments.map { Double($0) ?? 0.0 }
    }
    
    private func calculateMean(_ source: [Double]) -> Double {
        let sum: Double = source.reduce(0, +)
        return sum / Double(source.count)
    }
    
    private func calculateSumOfSquares(source: [Double], mean: Double) -> Double {
        return source.map({ pow($0 - mean, 2) }).reduce(0, +)
    }
}
