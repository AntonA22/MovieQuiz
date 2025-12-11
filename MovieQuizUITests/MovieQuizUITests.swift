//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Антон Абалуев on 04.12.2025.
//

import XCTest

class MovieQuizUITests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        // это специальная настройка для тестов: если один тест не прошёл,
        // то следующие тесты запускаться не будут; и правда, зачем ждать?
        continueAfterFailure = false
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
        app = nil
    }
    
    func testYesButton() {
        sleep(3)
        
        let firstPoster = app.images["Poster"]
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        
        app.buttons["Yes"].tap()
        sleep(3)
        
        let secondPoster = app.images["Poster"]
        let secondPosterData = secondPoster.screenshot().pngRepresentation

        let indexLabel = app.staticTexts["Index"]
       
        XCTAssertNotEqual(firstPosterData, secondPosterData)
        XCTAssertEqual(indexLabel.label, "2/10")

    }
    
    func testNoButton() {
        sleep(3)
        
        let firstPoster = app.images["Poster"]
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        
        app.buttons["No"].tap()
        sleep(3)
        
        let secondPoster = app.images["Poster"]
        let secondPosterData = secondPoster.screenshot().pngRepresentation

        let indexLabel = app.staticTexts["Index"]
       
        XCTAssertNotEqual(firstPosterData, secondPosterData)
        XCTAssertEqual(indexLabel.label, "2/10")
    }
    
    func testGameFinish() {
        // Ждём появления кнопки "Нет"
        let noButton = app.buttons["No"]
        XCTAssertTrue(noButton.waitForExistence(timeout: 5))

        // Проходим 10 вопросов, отвечая "Нет"
        for _ in 1...10 {
            noButton.tap()
            sleep(1) // даём интерфейсу обновиться
        }

        // Ищем алерт по ЗАГОЛОВКУ, как в приложении
        let alert = app.alerts["Этот раунд окончен!"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "Алерт с результатами игры не появился")

        // Проверяем заголовок
        XCTAssertEqual(alert.label, "Этот раунд окончен!")

        // Проверяем кнопку
        let button = alert.buttons["Сыграть ещё раз"]
        XCTAssertTrue(button.exists, "Кнопка 'Сыграть ещё раз' не найдена в алерте")
        XCTAssertEqual(button.label, "Сыграть ещё раз")
    }

    func testAlertDismiss() {
        // ждём, пока появится кнопка "Yes"
        let yesButton = app.buttons["Yes"]
        XCTAssertTrue(yesButton.waitForExistence(timeout: 5))

        // 10 раз жмём "Yes", чтобы закончить раунд
        for _ in 1...10 {
            yesButton.tap()
            sleep(1) // даём интерфейсу время обновиться
        }

        // Ищем алерт по заголовку
        let alert = app.alerts["Этот раунд окончен!"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "Алерт с результатами не появился")

        // Нажимаем на кнопку "Сыграть ещё раз"
        let replayButton = alert.buttons["Сыграть ещё раз"]
        XCTAssertTrue(replayButton.exists, "Кнопка 'Сыграть ещё раз' не найдена в алерте")
        replayButton.tap()

        // Даём времени интерфейсу
        sleep(2)

        // Проверяем счётчик
        let indexLabel = app.staticTexts["Index"]
        XCTAssertTrue(indexLabel.waitForExistence(timeout: 5))

        XCTAssertFalse(alert.exists, "Алерт не исчез после нажатия на кнопку")
        XCTAssertEqual(indexLabel.label, "1/10", "После начала нового раунда счётчик должен быть 1/10")
    }
}
