//
//  ViewController.swift
//  CommentApp
//
//  Created by 스마트스터디_김도형 on 2021/05/23.
//

import UIKit

class ViewController: UIViewController {
    //MARK:- IBOutlet
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var contentStack: UIStackView!
    
    private let commentViewModel = CommentViewModel(contentRefiner: ContentRefiner())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func inputButtonDidTouch(_ sender: UIButton) {
        writeToContentStack(author: authorTextField.text, content: contentTextField.text)
    }
    
    private func writeToContentStack(author: String?, content: String?) {
        guard let author = author, let content = content else { return }
        guard !author.isEmpty, !content.isEmpty else { return }
        
        // update view model
        commentViewModel.updateComments(author: author, content: content)
        
        // create CommentView
        guard let comment = commentViewModel.latestComment else { return }
        let commentView = CommentView(comment: comment)
        self.contentStack.addArrangedSubview(commentView)
    }
}

