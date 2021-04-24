//
//  TextRefiner_Improved.swift
//  TextRefiner_Improved
//
//  Created by gwonii on 2021/04/24.
//

import Foundation

struct TextRefiner_Improved {
    
    func refine(text: String, bannedWord: String? = nil) -> String {
        var result = text
            .replacingOccurrences(of: "\t", with: " ")
            .replacingOccurrences(of: "   ", with: " ")
            .replacingOccurrences(of: "  ", with: " ")
            .replacingOccurrences(of: "  ", with: " ")
        
        if let bannedWord = bannedWord {
            result = result
                .replacingOccurrences(of: bannedWord, with: String(repeating: "*", count: bannedWord.count))
        }
        return result
    }
}
