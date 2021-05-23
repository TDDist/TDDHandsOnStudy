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
    
    //MARK:- Properties
    private var contentRefiner: ContentRefinable!
    private let timeStamper = TimeStamper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentRefiner = ContentRefiner()
    }
    
    @IBAction func inputButtonDidTouch(_ sender: UIButton) {
        writeToContentStack(author: authorTextField.text, content: contentTextField.text)
    }
    
    private func writeToContentStack(author: String?, content: String?) {
        guard let author = author, let content = content else { return }
        guard !author.isEmpty, !content.isEmpty else { return }
        
        let comment = Comment(
            content: contentRefiner.execute(content: content, bannedWords: nil),
            author: author,
            time: timeStamper.makeTimeDescription()
        )
        
        let commentView = CommentView(comment: comment)
        self.contentStack.addArrangedSubview(commentView)
    }
}

