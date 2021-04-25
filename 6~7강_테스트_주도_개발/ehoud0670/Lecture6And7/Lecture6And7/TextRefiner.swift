//
//  TextRefiner.swift
//  Lecture6And7
//
//  Created by 스마트스터디_김도형 on 2021/04/25.
//

import Foundation

class TextRefiner {
    func execute(args: String) -> String {
        var source = args
        source = source.compactWhiteSpaces()
        
        return source
    }
}

private extension String {
    mutating func compactWhiteSpaces() -> String {
        guard containsDoubleEmpty() else { return self }
        
        self = replacingOccurrences(of: "  ", with: " ")
        return compactWhiteSpaces()
    }
    
    private func containsDoubleEmpty() -> Bool {
        for i in 0 ..< self.count {
            if containsDoubleEmpty(beginIndex: self.index(self.startIndex, offsetBy: i)) {
                return true
            }
        }
        return false
    }
    
    private func containsDoubleEmpty(beginIndex: String.Index) -> Bool {
        return self[beginIndex] == " " && self[self.index(after: beginIndex)] == " "
    }
}
