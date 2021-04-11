//
//  TextRefiner.swift
//  TextRefiner
//
//  Created by 스마트스터디_김도형 on 2021/04/10.
//

import Foundation

struct TextRefiner {
    static let emptyText: String.Element = " "
    
    func execute(texts: String) -> String {
        var result = texts
        
        var i = 0
        while i < result.count - 1 {
            let curIndex = result.index(result.startIndex, offsetBy: i)
            guard isContinousEmpty(texts: result, at: curIndex) else {
                i += 1
                continue
            }
            
            result = replaceEmptyTextOf(texts: result, atFirst: curIndex)
            i += 1
        }
        return result
    }
    
    private func isContinousEmpty(texts: String, at index: String.Index) -> Bool {
        return texts[index] == Self.emptyText && texts[texts.index(after: index)] == Self.emptyText
    }
    
    private func replaceEmptyTextOf(texts: String, atFirst firstIndex: String.Index) -> String {
        var result = texts
        
        let emptyTextRange = self.emptyTextRange(texts: result, firstIndex: firstIndex)
        let emptyCase = self.emptyCase(texts: result, firstIndex: firstIndex)
        switch emptyCase {
        case .middle:
            result.replaceSubrange(emptyTextRange, with: " ")
        case .end:
            result.replaceSubrange(emptyTextRange, with: "")
        }
        
        return result
    }
    
    enum EmptyCase {
        case middle
        case end
    }
    
    private func emptyCase(texts: String, firstIndex: String.Index) -> EmptyCase {
        for curIndex in texts.indices[firstIndex..<texts.endIndex] {
            guard texts[curIndex] != Self.emptyText else { continue }
            return .middle
        }
        return .end
    }
    
    private func emptyTextRange(texts: String, firstIndex: String.Index) -> Range<String.Index> {
        for curIndex in texts.indices[firstIndex..<texts.endIndex] {
            guard texts[curIndex] != Self.emptyText else { continue }
            return firstIndex ..< curIndex
        }
        
        return firstIndex ..< texts.endIndex
    }
}
