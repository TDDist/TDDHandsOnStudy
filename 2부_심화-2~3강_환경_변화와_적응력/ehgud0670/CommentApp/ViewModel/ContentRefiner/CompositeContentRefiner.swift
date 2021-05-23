//
//  ContentRefiner.swift
//  CommentApp
//
//  Created by 스마트스터디_김도형 on 2021/05/23.
//

import Foundation

final class CompositeContentRefiner: ContentRefinable {
    private let contentRefiners: [ContentRefinable]
    
    init(contentRefiners: [ContentRefinable]) {
        self.contentRefiners = contentRefiners
    }
    
    func refine(content: String) -> String {
        return self.contentRefiners.reduce(content) { (content, contentRefiner) -> String in
            contentRefiner.refine(content: content)
        }
    }
}
