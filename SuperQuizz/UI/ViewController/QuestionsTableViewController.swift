//
//  QuestionsTableViewController.swift
//  SuperQuizz
//
//  Created by formation6 on 04/12/2018.
//  Copyright © 2018 Clement Coxam. All rights reserved.
//

import UIKit

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
        
        tableView.register(UINib(nibName: "QuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionTableViewCell")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return questions.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"AnswerViewController") as? AnswerViewController else {
            return
        }
        
        vc.question = questions[indexPath.row]
        vc.setOnReponseAnswered { (questionAnswered, result) in
            
            //TODO : Mettre a jour la liste , ou faire un appel reseau , ou mettre a jour la base
            
            self.navigationController?.popViewController(animated: true)
            self.tableView.reloadData()
            
        }
        
        self.show(vc, sender: self)
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexpath) in
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateOrEditQuestionViewController") as! CreateOrEditQuestionViewController
            controller.delegate = self
            //controller.questionToEdit
            self.present(controller, animated: true, completion: nil)
            
        }
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexpath) in
            //TODO: delete question
            
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
    //a l'affichage recupere les questions du serveur
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Je recupere les questions depuis l'api client et je les ajoutes a ma liste
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
        //TODO: Maj de la question
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func userDidCreateQuestion(q: Question) {
        
        questions.append(q)
        self.tableView.reloadData()
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
