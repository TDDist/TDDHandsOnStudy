//
//  CommentView.swift
//  CommentApp
//
//  Created by 스마트스터디_김도형 on 2021/05/23.
//

import UIKit

final class CommentView: UIView {
    private var contentLabel: UILabel!
    private var authorLabel: UILabel!
    private var timeLabel: UILabel!
    
    init(content: String, author: String, time: String) {
        super.init(frame: .zero)
        configureContentLabel(content: content)
        configureAuthorLabel(author: author)
        configureTimeLabel(time: time)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureContentLabel(content: String) {
        self.contentLabel = LabelFactory().createLabel(text: content, size: 15)
        self.addSubview(contentLabel)
        self.contentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
    }
    
    private func configureAuthorLabel(author: String) {
        self.authorLabel = LabelFactory().createLabel(text: author)
        self.addSubview(authorLabel)
        self.authorLabel.topAnchor.constraint(equalTo: self.contentLabel.bottomAnchor, constant: 2).isActive = true
    }
    
    private func configureTimeLabel(time: String) {
        self.timeLabel = LabelFactory().createLabel(text: time)
        self.addSubview(timeLabel)
        self.timeLabel.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 2).isActive = true
    }
}
