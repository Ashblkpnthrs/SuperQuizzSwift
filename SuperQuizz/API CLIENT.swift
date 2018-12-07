//
//  API CLIENT.swift
//  SuperQuizz
//
//  Created by formation6 on 06/12/2018.
//  Copyright © 2018 Clement Coxam. All rights reserved.
//

import Foundation


class APIClient {
    
    static let instance = APIClient()
    
    private let urlServer = "http://192.168.10.171:3000"
    private init () {}
    
    
    //Recuperer toutes les questions
    func getAllQuestionsFromServer(onSuccess:@escaping ([Question])->(), onError:@escaping (Error)->())-> URLSessionTask {
        
        //préparation de la requete
        var request = URLRequest(url: URL(string: "\(urlServer)/questions")! )
        request.httpMethod = "GET"
        
        // preparation de la tache de telechargement des données
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // si j'ai de la donnée
            if let data = data {
                
                // Je la transforme en Array
                let dataArray = try! JSONSerialization.jsonObject(with: data, options: []) as! [Any]
                var questionsToreturn = [Question]()
                // pour chaque objet dans l'array
                for object in dataArray {
                    
                    let objectDictionary = object as! [String:Any]
                    //Recuperer les valeurs du dictionnaire
                    // question title
                    let title = objectDictionary["title"] as! String
                    // correct Answer>
                    let indexCorrectAnswer = objectDictionary["correct_answer"] as! Int
                    
                    // recupere les reponse
                    
                    // ajout les propositions
                    
                    let answer1 = objectDictionary["answer_1"] as! String
                    let answer2 = objectDictionary["answer_2"] as! String
                    let answer3 = objectDictionary["answer_3"] as! String
                    let answer4 = objectDictionary["answer_4"] as! String
                    
                    //Switch entre les différentes bonne réponse
                    
                    var correctAnswer = answer1
                    
                    switch indexCorrectAnswer {
                        
                    case 2:
                        correctAnswer = answer2
                    case 3:
                        correctAnswer = answer3
                    case 4:
                        correctAnswer = answer4
                    default:
                        correctAnswer = answer1
                    }
                    
                    let q : Question = Question(questionTitle: title, correctAnswer: correctAnswer)
                    // Je les ajoute a ma liste de question
                    
                    q.propositions.append(answer1)
                    q.propositions.append(answer2)
                    q.propositions.append(answer3)
                    q.propositions.append(answer4)
                    
                    questionsToreturn.append(q)
                }
                onSuccess(questionsToreturn)
                
            } else  {
                onError(error!)
            }
        }
        // lance la tache
        task.resume()
        
        // revoie la tache pour pouvoir l'annuler
        return task
    }
    
    // Delete la question
    func deleteQuestionFromServer(questiontodelete: Question , onSuccess:@escaping (Question)->(), onError:@escaping (Error)->())-> URLSessionTask{
        //préparation de la requete
        var request = URLRequest(url: URL(string: "\(urlServer)/questions/\(questiontodelete.questionId)")! )
        request.httpMethod = "DELETE"
        // chargement des données
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
            if let error = error {
                onError(error)
            } else {
                onSuccess(questiontodelete)
            }
           
    
            
        }
        return task
        
    }
    //TODO : Post
    
    //TODO : Put
}
