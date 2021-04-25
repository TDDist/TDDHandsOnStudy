//
//  TextRefiner_Refactor.swift
//  TextRefiner_Refactor
//
//  Created by gwonii on 2021/04/25.
//

import Foundation

struct TextRefiner_Refactor {
        
    func refine(text: String, bannedWord: String? = nil) -> String {
        var source = text

        let refineWhiteSpaces: [(String) -> String] = [
            nomalizeWhiteSpaces,
            compactWhiteSpaces
        ]
        source = refineWhiteSpaces.reduce(source, { (source, refine) in refine(source) })
        source = maskBannedWords(source, bannedWord)
        
        return source
    }
    
    private func nomalizeWhiteSpaces(_ source: String) -> String {
        return source.contains("\t")
            ? nomalizeWhiteSpaces(source.replacingOccurrences(of: "\t", with: " "))
            : source
    }
    
    private func compactWhiteSpaces(_ source: String) -> String {
        return source.contains("  ")
            ? compactWhiteSpaces(source.replacingOccurrences(of: "  ", with: " "))
            : source
    }
    
    private func maskBannedWords(_ source: String, _ bannedWord: String?) -> String {
        if let bannedWord = bannedWord {
            return source
                .replacingOccurrences(of: bannedWord, with: String(repeating: "*", count: bannedWord.count))
        }
        return source
    }
}
