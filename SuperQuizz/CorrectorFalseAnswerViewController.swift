//
//  CorrectorFalseAnswerViewController.swift
//  SuperQuizz
//
//  Created by formation6 on 04/12/2018.
//  Copyright © 2018 Clement Coxam. All rights reserved.
//

import UIKit

class CorrectorFalseAnswerViewController: UIViewController {
    
    var question : Question?

    @IBOutlet weak var correctAnswerTitleLabel: UILabel!
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
        } else {
            correctAnswerTitleLabel.text = "Wrong Answer"
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
