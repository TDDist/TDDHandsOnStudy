//
//  ContentsSectionView.swift
//  SimpleComment
//
//  Created by gwonii on 2021/05/22.
//

import UIKit
import RxSwift

final class ContentsSectionView: UITableView {
    
    private let viewModel: MainViewModel
    private let disposeBag: DisposeBag
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        self.disposeBag = .init()
        super.init(frame: .zero, style: .plain)
        initSelf()
        register(ContentCell.self, forCellReuseIdentifier: ContentCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSelf() {
        viewModel.commentsDriver
            .drive(self.rx.items(cellIdentifier: ContentCell.reuseIdentifier, cellType: ContentCell.self)) { (_, comment, cell) in
                cell.setup(comment: comment)
            }
            .disposed(by: disposeBag)
    }
}
