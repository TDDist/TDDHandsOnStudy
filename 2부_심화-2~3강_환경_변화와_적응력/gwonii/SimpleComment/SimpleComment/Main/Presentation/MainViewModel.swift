//
//  MainViewModel.swift
//  SimpleComment
//
//  Created by gwonii on 2021/05/22.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewModel {
    
    private let commentsRelay: BehaviorRelay<[Comment]> = .init(value: [])
    var commentsDriver: Driver<[Comment]> {
        return commentsRelay.asDriver()
    }
    
    private let createCommentUseCase: CreateCommentUseCase
    
    init() {
        createCommentUseCase = DefaultCreateCommentUseCase(refiner: CompositeStringRefiner(refiners: [TrimWhiteSpaces(), CompactWhiteSpaces()]))
    }
    
    func create(writer: String, content: String) {
        let newComment: Comment = createCommentUseCase.invoke(writer: writer, content: content)
        let comments: [Comment] = commentsRelay.value + [newComment]
        commentsRelay.accept(comments)
    }
}

