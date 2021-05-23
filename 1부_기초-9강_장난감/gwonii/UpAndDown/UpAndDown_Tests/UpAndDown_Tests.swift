//
//  UpAndDown_Tests.swift
//  UpAndDown_Tests
//
//  Created by gwonii on 2021/05/09.
//

import XCTest

import Quick
import Nimble
import RxSwift

class UpAndDown_Tests: XCTestCase {
    
    func tests_sut_is_incompleted_when_it_is_initialized() {
        
    }
    
    func tests_sut_correctly_prints_too_low_message_in_single_player_game() {
        // given
        let sut =  DefaultGameResultUseCase()
        let generator: PositiveIntegerGenerator = PositiveIntegerGeneratorStub()
        
        // when
        // input: 1, target: 50
        let target: Int = generator.make()
        let actual = sut.invoke(guess: 1, target: target).message
        
        // then
        expect(actual).to(equal("Your guess is too low.\nEnter your guess"))
    }
    
    func tests_sut_correctly_prints_too_high_message_in_single_player_game() {
        // given
        let sut =  DefaultGameResultUseCase()
        let generator: PositiveIntegerGenerator = PositiveIntegerGeneratorStub()
        
        // when
        // input: 51, target: 50
        let target: Int = generator.make()
        let actual = sut.invoke(guess: 51, target: target).message
        
        // then
        expect(actual).to(equal("Your guess is too high.\nEnter your guess"))
    }
    
    func tests_sut_correctly_prints_correct_message_in_single_player_game() {
        // given
        let sut =  DefaultGameResultUseCase()
        let generator: PositiveIntegerGenerator = PositiveIntegerGeneratorStub()
        
        // when
        // input: 50, target: 50
        let target: Int = generator.make()
        let actual = sut.invoke(guess: 50, target: target).message
        
        // then
        expect(actual).to(equal("Correct!"))
    }
    
    func tests_sut_correctly_prints_guess_count_if_single_player_game_finished() {
        
    }
}

class PositiveIntegerGeneratorStub: PositiveIntegerGenerator {
    func make() -> Int {
        return 50
    }
}
