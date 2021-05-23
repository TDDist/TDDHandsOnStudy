//
//  CompositeStringRefiner.swift
//  SimpleComment
//
//  Created by gwonii on 2021/05/23.
//

import Foundation

class CompositeStringRefiner: StringRefiner {
    
    private let refiners: [StringRefiner]
    
    init(refiners: [StringRefiner]) {
        self.refiners = refiners
    }
    
    func refine(_ content: String) -> String {
        return refiners.reduce(content, { (source, refiner) -> String in
            return refiner.refine(source)
        })
    }
}
