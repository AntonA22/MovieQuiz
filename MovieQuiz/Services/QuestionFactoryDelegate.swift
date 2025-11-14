//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Антон Абалуев on 07.11.2025.
//
import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)    
}
