//
//  TextRefiner.swift
//  TextRefiner
//
//  Created by gwonii on 2021/04/24.
//

import Foundation

struct TextRefiner {
    
    func refine(text: String) -> String {
        return text
            .replacingOccurrences(of: "   ", with: " ")
            .replacingOccurrences(of: "  ", with: " ")
    }
}
