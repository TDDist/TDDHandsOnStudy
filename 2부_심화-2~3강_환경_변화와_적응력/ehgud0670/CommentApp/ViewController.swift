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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentRefiner = ContentRefiner()
    }
    
    @IBAction func inputButtonDidTouch(_ sender: UIButton) {
        writeToContentStack(text: timeDescription(local: Locale(identifier: "KR")))
    }
    
    private func writeToContentStack(text: String) {
        let label = createLabel(text: timeDescription(local: Locale(identifier: "KR")))
        self.contentStack.addArrangedSubview(label)
    }
    
    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    private func timeDescription(date: Date = Date() ,local: Locale?) -> String {
        return date.description(with: local)
    }
}

