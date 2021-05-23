//
//  GameResultUseCase.swift
//  UpAndDown
//
//  Created by gwonii on 2021/05/09.
//

import Foundation

protocol GameResultUseCase {
    func invoke(guess: Int, target: Int) -> GameResultType
}
