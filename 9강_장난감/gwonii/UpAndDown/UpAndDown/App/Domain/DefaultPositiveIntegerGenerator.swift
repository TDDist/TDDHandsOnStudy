//
//  DefaultPositiveIntegerGenerator.swift
//  UpAndDown
//
//  Created by gwonii on 2021/05/09.
//

import Foundation

struct DefaultPositiveIntegerGenerator: PositiveIntegerGenerator {
    func make() -> Int {
        return Int.random(in: 1...100)
    }
}
