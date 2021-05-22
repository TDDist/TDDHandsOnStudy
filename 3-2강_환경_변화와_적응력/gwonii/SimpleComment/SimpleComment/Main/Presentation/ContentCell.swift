//
//  ContentCell.swift
//  SimpleComment
//
//  Created by gwonii on 2021/05/22.
//

import UIKit
import SnapKit

final class ContentCell: UITableViewCell {
    static let reuseIdentifier: String = "ContentCell"
    
    private let writerLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .primaryBlack
        return label
    }()
    private let contentLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .primaryBlack
        return label
    }()
    private let createdAtLabel: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .primaryBlack
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubviews()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(comment: Comment) {
        writerLabel.text = comment.writer
        contentLabel.text = comment.content
        createdAtLabel.text = comment.createdAt
    }
 
    private func initSubviews() {
        addSubview(writerLabel)
        addSubview(contentLabel)
        addSubview(createdAtLabel)
    }
    
    private func initConstraints() {
        writerLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(8)
            maker.top.equalToSuperview().offset(8)
        }
        contentLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(writerLabel.snp.trailing).offset(12)
            maker.top.equalTo(writerLabel.snp.top)
            maker.trailing.lessThanOrEqualToSuperview()
        }
        createdAtLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(writerLabel.snp.leading)
            maker.top.equalTo(writerLabel.snp.bottom).offset(4)
            maker.trailing.lessThanOrEqualToSuperview()
            maker.bottom.equalToSuperview().offset(-8)
        }
    }
}
