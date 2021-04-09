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
            let nextIndex = result.index(curIndex, offsetBy: 1)
            
            guard result[curIndex] == Self.emptyText,
                  result[nextIndex] == Self.emptyText else {
                i += 1
                continue
            }
            
            let emptyResult = findEmptyTextRangeOf(texts: result, firstIndex: curIndex)
            let emptyCase = emptyResult.0
            let emptyRange = emptyResult.1
            
            switch emptyCase {
            case .middle:
                result.replaceSubrange(emptyRange, with: " ")
            case .toEnd:
                result.replaceSubrange(emptyRange, with: "")
            }
            
            i += 1
        }
        return result
    }
    
    enum FindCase {
        case middle
        case toEnd
    }
    
    func findEmptyTextRangeOf(texts: String, firstIndex: String.Index) -> (FindCase, Range<String.Index>) {
        for curIndex in texts.indices[firstIndex..<texts.endIndex] {
            guard texts[curIndex] != Self.emptyText else { continue }
            return (.middle, firstIndex ..< curIndex)
        }
        
        return (.toEnd, firstIndex ..< texts.endIndex)
    }
    
}
