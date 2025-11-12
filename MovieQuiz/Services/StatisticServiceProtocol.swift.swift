//
//  StatisticServiceProtocol.swift.swift
//  MovieQuiz
//
//  Created by Антон Абалуев on 09.11.2025.
//

protocol StatisticServiceProtocol {
    var gamesCount: Int { get }
    var bestGame: GameResult { get }
    var totalAccuracy: Double { get }
    
    func store(correct count: Int, total amount: Int)
}
