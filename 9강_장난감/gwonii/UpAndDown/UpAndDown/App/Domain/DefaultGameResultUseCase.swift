//
//  DefaultGameResultUseCase.swift
//  UpAndDown
//
//  Created by gwonii on 2021/05/09.
//

import Foundation

class DefaultGameResultUseCase: GameResultUseCase {
    
    func invoke(guess: Int, target: Int) -> GameResultType {
        if guess < target {
            return .up
        } else if guess > target {
            return .down
        } else {
            return .correct
        }
    }
}
