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
    
    func invoke(writer: String, content: String) -> Comment {
        
        return Comment(writer: writer, content: content, createdAt: Date().description(with: .current))
    }
}
