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
    private let labelFactory = LabelFactory()
    
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
        
        let view = UIView()
        
        let contentLabel = labelFactory.createLabel(text: contentRefiner.execute(content: content, bannedWords: nil), size: 15)
        view.addSubview(contentLabel)
        contentLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 2).isActive = true
        
        let authorLabel = labelFactory.createLabel(text: author)
        view.addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 2).isActive = true
        
        let timeLabel = labelFactory.createCurrentTimeLabel()
        view.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 2).isActive = true
        
        self.contentStack.addArrangedSubview(view)
    }
}

