//
//  ContentRefiner.swift
//  CommentApp
//
//  Created by 스마트스터디_김도형 on 2021/05/23.
//

import Foundation

final class ContentRefiner: ContentRefinable {
    func execute(content: String, bannedWords: [String]?) -> String {
        var content = content
        content = trimWhiteSpaces(content)
        content = maskBannedWords(content, bannedWords: bannedWords)
        content = compactWhitespaces(content)
        return content
    }
    
    private func trimWhiteSpaces(_ content: String) -> String {
        return content.trimmingCharacters(in: [" "])
    }
    
    private func maskBannedWords(_ content: String, bannedWords: [String]?) -> String {
        guard let bannedWords = bannedWords else { return content }
        return bannedWords.reduce(content) { $0.replacingOccurrences(of: $1, with: String.init(repeating: "*", count: $1.count)) }
    }
    
    private func compactWhitespaces(_ content: String) -> String {
        return containsDoubleEmpty(content) ? compactWhitespaces(content.replacingOccurrences(of: "  ", with: " ")) : content
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
