//
//  CommentView.swift
//  CommentApp
//
//  Created by 스마트스터디_김도형 on 2021/05/23.
//

import UIKit

final class CommentView: UIView {
    private let contentLabel: UILabel
    private let authorLabel: UILabel
    private let timeLabel: UILabel
    
    init(content: String, author: String, timeDescription: String) {
        self.contentLabel = LabelFactory().createLabel(text: "")
        self.authorLabel = LabelFactory().createLabel(text: "")
        self.timeLabel = LabelFactory().createLabel(text: "")
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        self.contentLabel = LabelFactory().createLabel(text: "")
        self.authorLabel = LabelFactory().createLabel(text: "")
        self.timeLabel = LabelFactory().createLabel(text: "")
        super.init(coder: coder)
    }
    
    private func configureContentLabel() {
        
    }
    
    private func configureAuthorLabel() {
        
    }
    
    private func configureTimeLabel() {
        
    }
}
