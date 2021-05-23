//
//  TimeStamper.swift
//  CommentApp
//
//  Created by 스마트스터디_김도형 on 2021/05/23.
//

import Foundation

final class TimeStamper {
    func makeTimeDescription(date: Date = Date() ,local: Locale? = Locale(identifier: "KR")) -> String {
        return date.description(with: local)
    }
}
