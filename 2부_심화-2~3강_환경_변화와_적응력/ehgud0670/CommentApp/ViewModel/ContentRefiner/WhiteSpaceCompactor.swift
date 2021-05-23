//
//  WhiteSpaceCompactor.swift
//  CommentApp
//
//  Created by 스마트스터디_김도형 on 2021/05/23.
//

import Foundation

class WhiteSpaceCompactor: ContentRefinable {
    func refine(content: String) -> String {
        containsDoubleEmpty(content) ? refine(content: content.replacingOccurrences(of: "  ", with: " ")) : content
    }
    
    private func containsDoubleEmpty(_ content: String) -> Bool {
        for i in 0 ..< content.count {
            if containsDoubleEmpty(content, beginIndex: content.index(content.startIndex, offsetBy: i)) {
                return true
            }
        }
        return false
    }
    
    private func containsDoubleEmpty(_ content: String, beginIndex: String.Index) -> Bool {
        guard content.index(after: beginIndex) != content.endIndex else { return false }
        return content[beginIndex] == " " && content[content.index(after: beginIndex)] == " "
    }
}
