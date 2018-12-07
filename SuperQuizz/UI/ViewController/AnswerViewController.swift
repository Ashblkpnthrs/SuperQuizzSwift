//
//  ViewController.swift
//  SuperQuizz
//
//  Created by formation6 on 04/12/2018.
//  Copyright © 2018 Clement Coxam. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var question : Question?
    
    var onQuestionAnswered : ((_ question: Question , _ isCorrectAnswer : Bool)->())?
    
    
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var questionTitle: UILabel!
    
    @IBOutlet weak var progressQuestionBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        questionTitle.text = question?.questionTitle
        answerButton1.setTitle(question?.propositions[0], for: .normal)
        answerButton2.setTitle(question?.propositions[1], for: .normal)
        answerButton3.setTitle(question?.propositions[2], for: .normal)
        answerButton4.setTitle(question?.propositions[3], for: .normal)
        
       
    }
    
    @IBAction func onAnswerButtonTap(_ sender: UIButton) {
        
        let userChoice = sender.titleLabel?.text
        question?.userChoice = userChoice
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"CorrectorFalseAnswerViewController") as? CorrectorFalseAnswerViewController else {
            return
        }
        
        vc.question = question
        self.show(vc, sender: self)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

            DispatchQueue.global(qos: .userInitiated).async {
            for i in 0...10 {
                Thread.sleep(forTimeInterval:1)
                DispatchQueue.main.async(execute:{
                    self.progressQuestionBar.progress = Float(i) * 0.1
                })
            }
        }
    }
    
    func setOnReponseAnswered(closure : @escaping (_ question: Question,_ isCorrectAnswer :Bool)->()) {
        onQuestionAnswered = closure
    }
    
    
    func userDidChooseAnswer(isCorretAnswer : Bool) {
        //TODO / Faire animation de réussite ou d'échec
        
        self.dismiss(animated: true, completion: nil)
        onQuestionAnswered?(question!,isCorretAnswer)
    }
}

