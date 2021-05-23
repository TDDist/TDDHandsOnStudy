//
//  CreateCommentUseCase.swift
//  SimpleComment
//
//  Created by gwonii on 2021/05/22.
//

import Foundation

protocol CreateCommentUseCase {
    func invoke(writer: String, content: String) -> Comment
}

class DefaultCreateCommentUseCase: CreateCommentUseCase {
    
    private let refiner: StringRefiner
    
    init(refiner: StringRefiner) {
        self.refiner = refiner
    }
    
    func invoke(writer: String, content: String) -> Comment {
        return Comment(
            id: UUID(),
            writer: writer,
            content: refiner.refine(content),
            createdAt: Date().description(with: .current)
        )
    }
    
    
}
