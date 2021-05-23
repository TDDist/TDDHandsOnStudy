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
    @IBOutlet weak var outputTextView: UITextView!
    
    //MARK:- Properties
    private var contentRefiner: ContentRefinable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentRefiner = ContentRefiner()
    }
    
    @IBAction func inputButtonDidTouch(_ sender: UIButton) {
        
    }
}

