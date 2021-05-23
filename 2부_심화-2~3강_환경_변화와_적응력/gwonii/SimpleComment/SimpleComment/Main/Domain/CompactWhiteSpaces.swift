//
//  CompactWhiteSpaces.swift
//  SimpleComment
//
//  Created by gwonii on 2021/05/23.
//

import Foundation

class CompactWhiteSpaces: StringRefiner {
    func refine(_ content: String) -> String {
        return content.contains("  ") ? refine(content.replacingOccurrences(of: "  ", with: " ")) : content
    }
}
