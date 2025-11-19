//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Антон Абалуев on 09.11.2025.
//

// Расширяем при объявлении

import Foundation


final class StatisticService {
    private let storage: UserDefaults = .standard
    
    private enum Keys: String {
        case gamesCount          // Для счётчика сыгранных игр
        case bestGameCorrect     // Для количества правильных ответов в лучшей игре
        case bestGameTotal       // Для общего количества вопросов в лучшей игре
        case bestGameDate        // Для даты лучшей игры
        case totalCorrectAnswers // Для общего количества правильных ответов за все игры
        case totalQuestionsAsked // Для общего количества вопросов, заданных за все игры
    }
}

// или реализуем протокол с помощью расширения
extension StatisticService: StatisticServiceProtocol {
    
    var gamesCount: Int {
        get { storage.integer(forKey: Keys.gamesCount.rawValue) }
        set { storage.set(newValue, forKey: Keys.gamesCount.rawValue) }
    }
    
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: Keys.bestGameCorrect.rawValue)
            let total = storage.integer(forKey: Keys.bestGameTotal.rawValue)
            let date = storage.object(forKey: Keys.bestGameDate.rawValue) as? Date ?? Date()
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            storage.set(newValue.correct, forKey: Keys.bestGameCorrect.rawValue)
            storage.set(newValue.total, forKey: Keys.bestGameTotal.rawValue)
            storage.set(newValue.date, forKey: Keys.bestGameDate.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        let totalCorrect = storage.integer(forKey: Keys.totalCorrectAnswers.rawValue)
        let totalQuestions = storage.integer(forKey: Keys.totalQuestionsAsked.rawValue)
        guard totalQuestions >= 0 else { return 0.0 }
        return Double(totalCorrect) / Double(totalQuestions)
    }
    
    func store(correct count: Int, total amount: Int) {
        // Обновляем общий счет
        let totalCorrect = storage.integer(forKey: Keys.totalCorrectAnswers.rawValue) + count
        let totalQuestions = storage.integer(forKey: Keys.totalQuestionsAsked.rawValue) + amount
        storage.set(totalCorrect, forKey: Keys.totalCorrectAnswers.rawValue)
        storage.set(totalQuestions, forKey: Keys.totalQuestionsAsked.rawValue)
        
        // Увеличиваем счет сыгранных игр
        gamesCount += 1
        
        // Проверяем, нужно ли обновить лучшую игру
        if count > bestGame.correct {
            bestGame = GameResult(correct: count, total: amount, date: Date())
        }
    }
}
