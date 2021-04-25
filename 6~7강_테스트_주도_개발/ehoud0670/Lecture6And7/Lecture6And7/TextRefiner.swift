//
//  TextRefiner.swift
//  Lecture6And7
//
//  Created by 스마트스터디_김도형 on 2021/04/25.
//

import Foundation

class TextRefiner {
    func execute(args: String, bannedWords: [String]? = nil) -> String {
        var source = args
        source = source.normalizedWhiteSpaces()
        source = source.compactedWhiteSpaces()
        source = source.trimmingCharacters(in: [" "])
        if let bannedWords = bannedWords {
            source = source.mask(bannedWords: bannedWords)
        }
        
        return source
    }
}

private extension String {
    mutating func mask(bannedWords: [String]) -> String {
        return bannedWords.reduce(self) { $0.replacingOccurrences(of: $1, with: String.init(repeating: "*", count: $1.count)) }
    }
    
    func normalizedWhiteSpaces() -> String {
        return self.replacingOccurrences(of: "\t", with: " ")
    }
    
    mutating func compactedWhiteSpaces() -> String {
        guard containsDoubleEmpty() else { return self }
        
        self = replacingOccurrences(of: "  ", with: " ")
        return compactedWhiteSpaces()
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
        guard self.index(after: beginIndex) != self.endIndex else { return false }
        return self[beginIndex] == " " && self[self.index(after: beginIndex)] == " "
    }
}
