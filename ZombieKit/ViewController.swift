//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //The UI Elements from the storyboard   are already linked up for you.
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var b0: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    
    //Place your instance variables here
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    

    // This gets called when the UIViewController is loaded into memory when the app starts
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }


    //This action gets called when either the true or false button is pressed.
    @IBAction func answerPressed(_ sender: AnyObject) {
        checkAnswer(sender.tag)
        questionNumber = questionNumber + 1
        updateUI()
        
    }
    
    // This method will update all the views on screen (progress bar, score label, etc)
    func updateUI() {
        progressBar.frame.size.width = (view.frame.size.width / 21) * CGFloat(questionNumber)
        progressLabel.text = String(questionNumber) + "/\(allQuestions.list.count))"
        scoreLabel.text = "Score: " + String(score)
        nextQuestion()
    }

    //This method will update the question text and check if we reached the end.
    func nextQuestion() {
        if questionNumber <= 21 {
            questionLabel.text = allQuestions.list[questionNumber].questionTitle
            b0.setTitle(allQuestions.list[questionNumber].possibleAnswers[0], for: .normal)
            b1.setTitle(allQuestions.list[questionNumber].possibleAnswers[1], for: .normal)
            b2.setTitle(allQuestions.list[questionNumber].possibleAnswers[2], for: .normal)
            b3.setTitle(allQuestions.list[questionNumber].possibleAnswers[3], for: .normal)
        } else {
            let alert :UIAlertController?
            if score >= 0 && score <= 13 {
                alert = UIAlertController(title: "Sin depresión", message: "Recuerda que si en algún momento llegas a sentirte triste o diferente a como normalmente te sientes, es importante pedir orientación profesional o acercarte a una persona de confianza. Tu salud mental importa.", preferredStyle: .alert)
            } else if score >= 14 && score <= 19 {
                alert = UIAlertController(title: "Depresión leve", message: "Es importante que acudas con un médico, un psicólogo o una persona de confianza para poder recibir ayuda. Tu salud mental importa. Recuerda que puedes acudir al departamento de consejería y bienestar a solicitar ayuda.", preferredStyle: .alert)
            
            } else if score >= 20 && score <= 28 {
                alert = UIAlertController(title: "Depresión moderada", message: "Es importante que acudas con un médico, un psicólogo o una persona de confianza para poder recibir ayuda. Tu salud mental importa. Recuerda que puedes acudir al departamento de consejería y bienestar a solicitar ayuda", preferredStyle: .alert)
            } else {
                alert = UIAlertController(title: "Depresión severa", message: "Es importante que acudas con un médico, un psicólogo o una persona de confianza para poder recibir ayuda. Tu salud mental importa. Recuerda que puedes acudir al departamento de consejería y bienestar a solicitar ayuda. ", preferredStyle: .alert)
            }
            
            let restartAction = UIAlertAction(title: "Salir", style: .default, handler: { UIAlertAction in
                self.performSegue (withIdentifier: "SecondViewController", sender: self)
            })
            
            alert!.addAction(restartAction)
            present(alert!, animated: true, completion: nil)
        }
        
    }
    
    //This method will check if the user has got the right answer.
    func checkAnswer(_ percsc: Int) {
            score += percsc
    }
    
    
    //This method will wipe the board clean, so that users can retake the quiz.
    func startOver() {
        questionNumber = 0
        score = 0
        updateUI()
    }

}

