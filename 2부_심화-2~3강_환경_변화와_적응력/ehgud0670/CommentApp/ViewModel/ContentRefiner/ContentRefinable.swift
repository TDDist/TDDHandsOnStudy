//
//  ContentRefinable.swift
//  CommentApp
//
//  Created by 스마트스터디_김도형 on 2021/05/23.
//

import Foundation

protocol ContentRefinable {
    func execute(content: String, bannedWords: [String]?) -> String
}
