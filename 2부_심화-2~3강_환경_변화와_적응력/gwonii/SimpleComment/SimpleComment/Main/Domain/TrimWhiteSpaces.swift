//
//  TrimWhiteSpaces.swift
//  SimpleComment
//
//  Created by gwonii on 2021/05/23.
//

import Foundation

class TrimWhiteSpaces: StringRefiner {
    func refine(_ content: String) -> String {
        return content.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
