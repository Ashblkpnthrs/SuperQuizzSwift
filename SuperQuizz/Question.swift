//
//  Question.swift
//  SuperQuizz
//
//  Created by formation6 on 04/12/2018.
//  Copyright © 2018 Clement Coxam. All rights reserved.
//

import Foundation


class Question {
    
    var questionTitle : String = ""
    var correctAnswer : String = ""
    var userChoice : String?
    var propositions = [String]()
    
    
    init(questionTitle : String , correctAnswer : String) {
        self.questionTitle = questionTitle
        self.correctAnswer = correctAnswer
    }
    
    func isCorrectAnswer(answer: String) -> Bool{
        return correctAnswer == answer
    }
    
    func isQuestionAnswered() -> Bool {
        return userChoice != nil
    }
    
}
