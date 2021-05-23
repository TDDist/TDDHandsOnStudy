//
//  InputSectionView.swift
//  SimpleComment
//
//  Created by gwonii on 2021/05/22.
//

import UIKit
import RxSwift

final class InputSectionView: UIView {
    
    private let textFieldWidth: CGFloat = UIScreen.main.bounds.width * 0.4
    
    private let viewModel: MainViewModel
    private let disposeBag: DisposeBag
    
    private let writerTextField: UITextField = {
        let textField: UITextField = .init(frame: .zero)
        textField.placeholder = "작성자"
        textField.font = .systemFont(ofSize: 16, weight: .light)
        textField.textColor = .primaryBlack
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.primaryBlack.cgColor
        textField.layer.masksToBounds = true
        return textField
    }()
    private let contentTextField: UITextField = {
        let textField: UITextField = .init(frame: .zero)
        textField.placeholder = "내용"
        textField.font = .systemFont(ofSize: 16, weight: .light)
        textField.textColor = .primaryBlack
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.primaryBlack.cgColor
        textField.layer.masksToBounds = true
        return textField
    }()
    private let createButton: UIButton = {
        let button: UIButton = .init(type: .custom)
        button.setTitle("생성", for: .normal)
        button.setTitleColor(.primaryBlack, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        self.disposeBag = .init()
        super.init(frame: .zero)
        
        initSubviews()
        initContraints()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubviews() {
        addSubview(writerTextField)
        addSubview(contentTextField)
        addSubview(createButton)
    }
    
    private func initContraints() {
        writerTextField.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview()
            maker.width.equalTo(textFieldWidth)
            maker.bottom.equalToSuperview()
        }
        contentTextField.snp.makeConstraints { maker in
            maker.leading.equalTo(writerTextField.snp.trailing).offset(8)
            maker.top.equalTo(writerTextField.snp.top)
            maker.width.equalTo(textFieldWidth)
        }
        createButton.snp.makeConstraints { maker in
            maker.leading.equalTo(contentTextField.snp.trailing)
            maker.top.equalTo(writerTextField)
            maker.trailing.equalToSuperview()
        }
    }
    
    private func bind() {
        createButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.viewModel.create(writer: self?.writerTextField.text ?? "", content: self?.contentTextField.text ?? "")
            })
            .disposed(by: disposeBag)
    }
}


