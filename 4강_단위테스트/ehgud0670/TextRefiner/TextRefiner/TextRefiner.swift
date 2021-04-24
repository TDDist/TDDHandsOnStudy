//
//  TextRefiner.swift
//  TextRefiner
//
//  Created by 스마트스터디_김도형 on 2021/04/10.
//

import Foundation

struct TextRefiner {
    func execute(texts: String) -> String {
        var result = texts
        
        var i = 0
        while i < result.count - 1 {
            let curIndex = result.index(result.startIndex, offsetBy: i)
            if result.isContainsDoubleEmpty(beginIndex: curIndex) {
                result = result.replacingEmptyText(beginIndex: curIndex)
            }
            i += 1
        }
        return result
    }
}

private extension String {
    static let emptyText: String.Element = " "
    
    func isContainsDoubleEmpty(beginIndex: String.Index) -> Bool {
        return self[beginIndex] == Self.emptyText && self[self.index(after: beginIndex)] == Self.emptyText
    }
    
    mutating func replacingEmptyText(beginIndex: String.Index) -> String {
        let emptyTextRange = self.emptyTextRange(beginIndex: beginIndex)
        let emptyCase = self.emptyCase(beginIndex: beginIndex)
        switch emptyCase {
        case .middle:
            self.replaceSubrange(emptyTextRange, with: " ")
        case .end:
            self.replaceSubrange(emptyTextRange, with: "")
        }
        
        return self
    }
    
    private enum EmptyCase {
        case middle
        case end
    }
    
    private func emptyCase(beginIndex: String.Index) -> EmptyCase {
        for curIndex in self.indices[beginIndex ..< self.endIndex] {
            guard self[curIndex] != Self.emptyText else { continue }
            return .middle
        }
        return .end
    }
    
    private func emptyTextRange(beginIndex: String.Index) -> Range<String.Index> {
        for curIndex in self.indices[beginIndex ..< self.endIndex] {
            guard self[curIndex] != Self.emptyText else { continue }
            return beginIndex ..< curIndex
        }
        
        return beginIndex ..< self.endIndex
    }
}
