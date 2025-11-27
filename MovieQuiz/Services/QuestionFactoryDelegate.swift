//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Антон Абалуев on 07.11.2025.
//
import Foundation

protocol QuestionFactoryDelegate {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer() // сообщение об успешной загрузке
    func didFailToLoadData(with error: Error) // сообщение об ошибке загрузки
}
