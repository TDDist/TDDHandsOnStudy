//
//  LabelFactory.swift
//  CommentApp
//
//  Created by 스마트스터디_김도형 on 2021/05/23.
//

import UIKit

class LabelFactory {
    func createLabel(text: String, size: CGFloat = 10) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: size)
        return label
    }
}
