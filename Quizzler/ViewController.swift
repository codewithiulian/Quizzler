//
//  ViewController.swift
//  Quizzler
//
//  Created by Iulian Oana on 30/07/2019.
//  Copyright (c) 2019 Iulian Oana. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    //Place your instance variables here
    let questionBank : QuestionBank = QuestionBank()
    // Declare the IBoutlets needed.
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    // Define the initial question index.
    var questionIndex : Int = 0
    // Declare the given answer and if it's correct.
    var givenAnswer : Bool = false
    var isAnswerCorrect : Bool = false
    // Declare a total questions local variable.
    var totalQuestions : Int = 0
    // Declare the initial score.
    var currentScore = 0
    
    // When the app loads.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Define the total count of questions.
        totalQuestions = questionBank.list.count
        showQuestion()
    }

    // Answer buttons press callback (Touch Up Inside)
    @IBAction func answerPressed(_ sender: AnyObject) {
        // Get the given answer.
        givenAnswer = Bool(truncating: sender.tag as NSNumber)
        // Check it's correct.
        isAnswerCorrect = checkAnswer(givenAnswer, questionBank.list[questionIndex].answer)
        // Process answer.
        processAnswer(isAnswerCorrect)
        // Update UI.
        updateUI()
    }
    
    
    // Responsible for processing the answer.
    func processAnswer(_ isCorrect: Bool) {
        // Do actions based on answer.
        if isCorrect {
            currentScore += 1
        }
    }
    
    // Responsible for updating the screen based on different actions.
    func updateUI() {
        // If the user hasn't reached the limit.
        if !hasReachedLimit() {
            // While the user hasn't finished yet.
            // Show next question.
            nextQuestion()
            showQuestion()
        }
        // If the user has reached the limit.
        else {
            // Alert the message.
            alertUser()
        }
    }
    
    func alertUser() {
        // Define the UI Alert Controller object.
        let alert = UIAlertController(title: "Great", message: "The quiz is finished.\nDo you want to start over?", preferredStyle: .alert )
        // Declare the UI Alert Action to handle the alert.
        let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
            // Start over on callback.
            self.startOver()
        }
        // Add the action to the alert instance.
        alert.addAction(restartAction)
        // Show it to the screen.
        present(alert, animated: true, completion: nil)
    }
    
    // Check if we've reached the end of the question list.
    func hasReachedLimit() -> Bool {
        return questionIndex == totalQuestions - 1
    }
    
    // Update the score on the screen.
    func updateScore() {
        // Update the score text.
        scoreLabel.text = "Score \(String(currentScore))"
        // Update the question counter.
        progressLabel.text = "\(String(questionIndex+1))/\(String(totalQuestions))"
        // Update the progress bar.
        // Get the (width of the screen divided by the number of questions) x current question.
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(totalQuestions)) * CGFloat(questionIndex+1)
    }
    
    func showQuestion() {
        updateScore()
        // Update the question.
        questionLabel.text = questionBank.list[questionIndex].questionText
    }
    
    // Responsible for showing the next question.
    func nextQuestion() {
        if questionIndex > 0 {
            showQuestion()
        }
        // Increment the question index.
        questionIndex += 1
    }
    
    // Responsible for veryfying the answer.
    // Returns true if correct and false if not.
    func checkAnswer(_ answer: Bool, _ actual: Bool) -> Bool {
        return answer == actual
    }
    
    // Restarts the quiz.
    func startOver() {
        // Reset the current user score.
        currentScore = 0
        // Reset the question index.
        questionIndex = 0;
        // Show the first question.
        showQuestion()
    }
}
