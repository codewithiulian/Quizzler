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
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    var questionIndex : Int = 0
    
    var givenAnswer : Bool = false
    var isAnswerCorrect : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questionBank.list[questionIndex].questionText
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        // Get the given answer.
        givenAnswer = Bool(truncating: sender.tag as NSNumber)
        // Check it's correct.
        isAnswerCorrect = checkAnswer(givenAnswer, questionBank.list[questionIndex].answer)
        // Do actions based on answer.
        if isAnswerCorrect {
            print("Correct")
        }else{
            print("Wrong")
        }
        // Update UI.
        updateUI()
    }
    
    
    func updateUI() {
        // Show next question.
        nextQuestion()
        // Update the question.
        questionLabel.text = questionBank.list[questionIndex].questionText
    }
    

    func nextQuestion() {
        // Increment the question index.
        questionIndex += 1
    }
    
    
    func checkAnswer(_ answer: Bool, _ actual: Bool) -> Bool {
        return answer == actual
    }
    
    
    func startOver() {
       
    }
    

    
}
