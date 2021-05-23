//
//  CommentViewModel.swift
//  CommentApp
//
//  Created by 스마트스터디_김도형 on 2021/05/23.
//

import Foundation

final class CommentViewModel {
    private var contentRefiner: ContentRefinable!
    private let timeStamper: TimeStamper
    private var comments = [Comment]()
    
    init(contentRefiner: ContentRefinable, timeStamper: TimeStamper = TimeStamper()) {
        self.contentRefiner = contentRefiner
        self.timeStamper = timeStamper
    }
    
    func updateComments(author: String, content: String) {
        let comment = Comment(
            content: contentRefiner.refine(content: content),
            author: author,
            time: timeStamper.makeTimeDescription()
        )
        
        comments.append(comment)
    }
    
    var latestComment: Comment? {
        return comments.last
    }
}
