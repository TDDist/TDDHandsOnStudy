//
//  GameResultType.swift
//  UpAndDown
//
//  Created by gwonii on 2021/05/09.
//

import Foundation

enum GameResultType {
    case up
    case down
    case correct
    
    var message: String {
        switch self {
        case .up:
            return "Your guess is too low.\nEnter your guess"
        case .down:
            return "Your guess is too high.\nEnter your guess"
        case .correct:
            return "Correct!"
        }
    }
}
