//
//  CreateOrEditQuestionViewController.swift
//  SuperQuizz
//
//  Created by formation6 on 05/12/2018.
//  Copyright © 2018 Clement Coxam. All rights reserved.
//

import UIKit

protocol CreateOrEditQuestionDelegate : AnyObject {
    func userDidEditQuestion(q : Question) -> ()
    func userDidCreateQuestion(q : Question) -> ()
}

class CreateOrEditQuestionViewController: UIViewController {
    
    var questionToEdit: Question?
    weak var delegate : CreateOrEditQuestionDelegate?
    
    @IBOutlet weak var questionTitleTextField: UITextField!
    @IBOutlet weak var answerTextField1: UITextField!
    @IBOutlet weak var answerTextField2: UITextField!
    @IBOutlet weak var answerTextField3: UITextField!
    @IBOutlet weak var answerTextField4: UITextField!
    
    @IBOutlet weak var answerSwitch1: UISwitch!
    @IBOutlet weak var answerSwitch2: UISwitch!
    @IBOutlet weak var answerSwitch3: UISwitch!
    @IBOutlet weak var answerSwitch4: UISwitch!
    
    
    @IBAction func validationAnswerSwitch(_ sender: UISwitch) {
        
        if sender.isOn == true {
            
            answerSwitch1.setOn(false, animated: true)
            answerSwitch2.setOn(false, animated: true)
            answerSwitch3.setOn(false, animated: true)
            answerSwitch4.setOn(false, animated: true)
            
            sender.setOn(true, animated: false)
            
        } else {
            print("You need to check Button")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let question = questionToEdit{
             questionTitleTextField.text = question.questionTitle
             answerTextField1.text = question.propositions[0]
             answerTextField2.text = question.propositions[1]
             answerTextField3.text = question.propositions[2]
             answerTextField4.text = question.propositions[3]
           
        }
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        answerSwitch1.setOn(true, animated: true)
    }
    
    func createOrEditQuestion () {
        
        var correctAnswer = answerTextField1.text
        
        if answerSwitch1.isOn {
            correctAnswer = answerTextField1.text
        }
        if answerSwitch2.isOn {
            correctAnswer = answerTextField2.text
        }else if answerSwitch3.isOn {
            correctAnswer = answerTextField3.text
        }else if answerSwitch4.isOn {
            correctAnswer = answerTextField4.text
        }
        
        if let question = questionToEdit {
            
            question.questionTitle = (questionTitleTextField.text)!
            question.propositions.append(answerTextField1.text!)
            question.propositions.append(answerTextField2.text!)
            question.propositions.append(answerTextField3.text!)
            question.propositions.append(answerTextField4.text!)
            
            
            delegate?.userDidEditQuestion(q: question)
        } else {
            //TODO creer une nouvelle question
            let question = Question(questionTitle:"", correctAnswer: correctAnswer ?? "" )
            question.questionTitle = questionTitleTextField.text!
            question.propositions = [answerTextField1.text, answerTextField2.text, answerTextField3.text, answerTextField4.text] as! [String]
            delegate?.userDidCreateQuestion(q: question)
        }
    }
    
    @IBAction func createQuestionButton(_ sender: UIButton) {
        createOrEditQuestion()
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
