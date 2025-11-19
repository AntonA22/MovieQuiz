//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Антон Абалуев on 09.11.2025.
//

struct AlertModel {
    var title: String
    var message: String
    var buttonText: String
    var completion: () -> Void
}
