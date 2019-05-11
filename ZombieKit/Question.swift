//
//  Question.swift
//  Quizzler
//
//  Created by Angela Yu on 26/08/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import Foundation

class Question {
    let questionTitle : String
    let possibleAnswers : [String]
    
    init(_ text : String, _ possible : [String]) {
        questionTitle = text
        possibleAnswers = possible
    }
    
}

