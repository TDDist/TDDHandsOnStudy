//
//  CommentView.swift
//  CommentApp
//
//  Created by 스마트스터디_김도형 on 2021/05/23.
//

import UIKit

final class CommentViewFactory {
    private var commentView: UIView!
    private var contentLabel: UIView!
    private var authorLabel: UIView!
    private var timeLabel: UIView!
    private let labelFactory: LabelFactory
    
    init(labelFactory: LabelFactory) {
        self.labelFactory = labelFactory
    }
    
    func createCommentView(content: String, author: String, time: String) -> UIView {
        self.commentView = UIView()
        configureContentLabel(content: content)
        configureAuthorLabel(author: author)
        configureTimeLabel(time: time)
        return commentView
    }

    private func configureContentLabel(content: String) {
        self.contentLabel = labelFactory.createLabel(text: content, size: 15)
        commentView.addSubview(contentLabel)
        contentLabel.topAnchor.constraint(equalTo: commentView.topAnchor, constant: 2).isActive = true
    }
    
    private func configureAuthorLabel(author: String) {
        self.authorLabel = labelFactory.createLabel(text: author)
        commentView.addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 2).isActive = true
    }
    
    private func configureTimeLabel(time: String) {
        self.timeLabel = labelFactory.createLabel(text: time)
        commentView.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 2).isActive = true
    }
}
