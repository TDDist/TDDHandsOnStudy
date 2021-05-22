//
//  MainViewController.swift
//  SimpleComment
//
//  Created by gwonii on 2021/05/22.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel! = .init()
    
    private let inputSectionView: InputSectionView
    private let contentsSectionView: ContentsSectionView
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.inputSectionView = .init(viewModel: viewModel)
        self.contentsSectionView = .init(viewModel: viewModel)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        initSelf()
        initSubviews()
        initConstraints()
    }
    
    private func initSelf() {
        view.backgroundColor = .white
    }
    
    private func initSubviews() {
        view.addSubview(inputSectionView)
        view.addSubview(contentsSectionView)
    }
    
    private func initConstraints() {
        inputSectionView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(8)
            maker.top.equalTo(self.view.safeAreaLayoutGuide)
            maker.trailing.equalToSuperview().offset(-8)
        }
        contentsSectionView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalTo(inputSectionView.snp.bottom).offset(12)
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
}
