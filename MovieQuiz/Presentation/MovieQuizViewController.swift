import UIKit



final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol  {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Private Constants
    

    // MARK: - Private Properties
    
    private var alertPresenter = AlertPresenter()
    
    private var presenter: MovieQuizPresenter!
    
    // MARK: - IBAction
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
    }
    
    // MARK: - Private Methods
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false // говорим, что индикатор загрузки не скрыт
        activityIndicator.startAnimating() // включаем анимацию
    }
    
    func showNetworkError(message: String) {
        activityIndicator.isHidden = true
        
        let model = AlertModel(title: "Ошибка",
                               message: message,
                               buttonText: "Попробовать еще раз") { [weak self] in
            guard let self = self else { return }
            
            self.presenter.restartGame()
            
        }
        
        alertPresenter.show(in: self, model: model)
    }
    
    // приватный метод вывода на экран вопроса, который принимает на вход вью модель вопроса и ничего не возвращает
    func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
        
        // рамки
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0
        imageView.layer.cornerRadius = 20
        
        //включаем кнопки
        noButton.isEnabled = true
        yesButton.isEnabled = true
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
    }
    
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
    }
    
    // приватный метод для показа результатов раунда квиза
    // принимает вью модель QuizResultsViewModel и ничего не возвращает
    func show(quiz result: QuizResultsViewModel) {
        let message = presenter.makeResultsMessage()

        let alert = UIAlertController(
            title: result.title,
            message: message,
            preferredStyle: .alert)
            
        let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
                guard let self = self else { return }
                
                self.presenter.restartGame()
        }

        alert.addAction(action)

        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        presenter = MovieQuizPresenter(viewController: self)
        
        imageView.layer.cornerRadius = 20

        showLoadingIndicator()
    }
}



extension MovieQuizViewController {
    
}
