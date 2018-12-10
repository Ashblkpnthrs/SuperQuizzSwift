//
//  QuestionsTableViewController.swift
//  SuperQuizz
//
//  Created by formation6 on 04/12/2018.
//  Copyright © 2018 Clement Coxam. All rights reserved.
//

import UIKit
import SwiftIcons

class QuestionsTableViewController: UITableViewController {
    
    var questions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let question1 = Question(questionTitle: "Quelle est la capitale de la France ?", correctAnswer: "Paris")
        
        question1.propositions.append("New-York")
        question1.propositions.append("Londres")
        question1.propositions.append("Paris")
        question1.propositions.append("Madrid")
        
        questions.append(question1)
        
        let question2 = Question(questionTitle: "Qui est le réalisateur de Nightmare before Christmas ?" , correctAnswer : "Henry Sellick")
        
        question2.propositions.append("Steven Spielberg")
        question2.propositions.append("Tim Burton")
        question2.propositions.append("Jim Hanson")
        question2.propositions.append("Henry Sellick")
        
        questions.append(question2)
        
        let question3 = Question(questionTitle: "Quel est le créateur de l'Alien dans le film éponyme ?" , correctAnswer : "HR Giger")
        
        question3.propositions.append("Dan Obanon")
        question3.propositions.append("Stan Winston")
        question3.propositions.append("Franck Oz")
        question3.propositions.append("HR Giger")
        
        questions.append(question3)
        
        tableView.register(UINib(nibName: "QuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionTableViewCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"AnswerViewController") as? AnswerViewController else {
            return
        }
        
        vc.question = questions[indexPath.row]
        vc.setOnReponseAnswered { (questionAnswered, result) in
            
            self.navigationController?.popViewController(animated: true)
            self.tableView.reloadData()
            
        }
        
        self.show(vc, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexpath) in
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateOrEditQuestionViewController") as! CreateOrEditQuestionViewController
            controller.delegate = self
            controller.questionToEdit = self.questions [indexPath.row]
            self.present(controller, animated: true, completion: nil)
        }
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexpath) in
            
            APIClient.instance.deleteQuestionFromServer(questiontodelete: self.questions[indexPath.row], onSuccess: { (q) in
                self.questions.remove(at: indexPath.row)
            }, onError: { (Error) in
                print(Error)
            })
            self.tableView.reloadData()
            
        }
        
        return [editAction,deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath) as! QuestionTableViewCell
        
        cell.questionTitleLabel.text = questions[indexPath.row].questionTitle
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCreateOrEditViewController" {
            let controller = segue.destination as! CreateOrEditQuestionViewController
            controller.delegate = self as! CreateOrEditQuestionDelegate
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIClient.instance.getAllQuestionsFromServer(onSuccess: { (questions) in self.questions = questions
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
}
extension QuestionsTableViewController : CreateOrEditQuestionDelegate {
    func userDidEditQuestion(q: Question) {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func userDidCreateQuestion(q: Question) {
        
        questions.append(q)
        self.tableView.reloadData()
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}

