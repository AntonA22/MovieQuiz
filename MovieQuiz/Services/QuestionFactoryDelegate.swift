//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Антон Абалуев on 07.11.2025.
//
import Foundation

protocol QuestionFactoryDelegate: AnyObject {               // 1
    func didReceiveNextQuestion(question: QuizQuestion?)    // 2
}
