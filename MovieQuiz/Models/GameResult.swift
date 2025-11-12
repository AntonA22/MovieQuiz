//
//  GameResult.swift
//  MovieQuiz
//
//  Created by Антон Абалуев on 09.11.2025.
//

import Foundation

struct GameResult {
    let correct: Int
    let total: Int
    let date: Date

    // метод сравнения по количеству верных ответов
    func isBetterThan(_ another: GameResult) -> Bool {
        correct > another.correct
    }
}
