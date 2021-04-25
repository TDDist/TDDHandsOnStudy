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
        let n = args.count
        
        if n == 0 {
            throw VarianceError.noInput
        }
        
        if n == 1 {
            throw VarianceError.oneInput
        }
        
        var source: [Double] = [Double].init(repeating: 0.0, count: n)
        for i in 0 ..< source.count {
            guard let number = Double(args[i]) else { continue }
            source[i] = number
        }
        print(source)
        
        var sum: Double = 0.0
        for i in 0 ..< source.count {
            sum += source[i]
        }
        
        let mean: Double = sum / Double(source.count)
        var sumOfSquares = 0.0
        for i in 0 ..< source.count {
            sumOfSquares += (source[i] - mean) * (source[i] - mean)
        }
        
        let variance = sumOfSquares / Double(source.count - 1)
        return variance
    }
}
