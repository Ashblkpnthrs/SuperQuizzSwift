//
//  CorrectorFalseAnswerViewController.swift
//  SuperQuizz
//
//  Created by formation6 on 04/12/2018.
//  Copyright © 2018 Clement Coxam. All rights reserved.
//

import UIKit
import SwiftIcons

class CorrectorFalseAnswerViewController: UIViewController {
    
    var question : Question?
    
    @IBOutlet weak var correctAnswerTitleLabel: UILabel!
    @IBOutlet weak var correctAnswerIcons: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let question = question else {
            return
        }
        guard let userAnswer = question.userChoice else {
            return
        }
        if question.isCorrectAnswer (answer : userAnswer) {
            correctAnswerTitleLabel.text = "Correct Answer"
            correctAnswerIcons.setIcon(icon: .fontAwesomeSolid(.check), iconSize: 50, color: .green, forState: .normal)
            
        } else {
            correctAnswerTitleLabel.text = "Wrong Answer"
            correctAnswerIcons.setIcon(icon: .fontAwesomeSolid(.times), iconSize: 50, color: .red, forState: .normal)
        }
    }
}
