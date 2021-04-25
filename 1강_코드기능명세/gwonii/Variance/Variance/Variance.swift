//
//  Variance.swift
//  Variance
//
//  Created by gwonii on 2021/04/25.
//

import Foundation

struct Variance {
    
    func getVariance() {
        if let inputText = readLine() {
            
            if inputText.count < 0 {
                print("데이터가 입력되지 않았습니다.")
                return
            }
            
            if inputText.count == 1 {
                print("2개 이상의 데이터를 입력하세요.")
                return
            }
            
            let values: [Double] = inputText.compactMap { character -> Double? in
                return Double(character.description)
            }
            
            let sum = values.reduce(0, { $0 + $1 })
            let mean = sum / Double(values.count)
            let sumOfSquare = values.map { value -> Double in
                return (value - mean) * (value - mean)
            }
            .reduce(0, { $0 + $1 })
            let variance = sumOfSquare / Double(values.count - 1)
            
            print("variance is \(variance)")
            return
        }
    }
}
