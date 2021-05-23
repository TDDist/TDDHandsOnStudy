//
//  BanndedWordMasker.swift
//  CommentApp
//
//  Created by 스마트스터디_김도형 on 2021/05/23.
//

import Foundation

class BannedWordMasker: ContentRefinable {
    private let bannedWords: [String]
    
    init(bannedWords: [String]) {
        self.bannedWords = bannedWords
    }
    
    func refine(content: String) -> String {
        return bannedWords.reduce(content) { $0.replacingOccurrences(of: $1, with: String.init(repeating: "*", count: $1.count)) }
    }
}
