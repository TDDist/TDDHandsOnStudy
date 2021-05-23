//
//  WhiteSpaceTrimmer.swift
//  CommentApp
//
//  Created by 스마트스터디_김도형 on 2021/05/23.
//

import Foundation

class WhiteSpaceTrimmer: ContentRefinable {
    func refine(content: String) -> String {
        return content.trimmingCharacters(in: [" "])
    }
}

