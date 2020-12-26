//
//  ModelManager.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 10/10/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import Foundation
import UIKit

var sharedInstance = ModelManager()

class ModelManager{
    
    var database:FMDatabase? = nil
    static func getInstance()->ModelManager{
        if sharedInstance.database == nil{
            sharedInstance.database = FMDatabase(path: Util.shared.getPath(dbName: "tests.db"))
        }
        return sharedInstance
    }
    
    //MARK:-Saving data
    
    func saveData(question:QuestionModel) -> Bool{
        sharedInstance.database?.open()
        let tableName: String = "questions_table".localized
        let isSave = sharedInstance.database?.executeUpdate("INSERT INTO \(tableName)(topic_id, question_id) VALUES(?,?)", withArgumentsIn: [question.topicId, question.questionId])
        sharedInstance.database?.close()
        return isSave!
    }
    
    
    //MARK:-Fetching questions data
    
    func getAllTopics()->[TopicModel]{
        sharedInstance.database?.open()
        var topics = [TopicModel]()
        let topicsName: String = "topics_table".localized
        do{
            let resultset :FMResultSet? = try sharedInstance.database?.executeQuery("SELECT * FROM \(topicsName)", values: nil)
        
            if resultset != nil {
                while resultset!.next() {
                    let topicId = resultset!.int(forColumnIndex: 0)
                    let topicName = resultset!.string(forColumnIndex: 1)
                    let topic = TopicModel(topic_id:Int(topicId), topic_name: topicName!)
                    topics.append(topic)
                }
            }
        }
        catch let error{
            print(error.localizedDescription)
        }
        
        sharedInstance.database?.close()
        return topics
    }
    
    
    func getAllQuestions() -> [QuestionModel]{
        sharedInstance.database?.open()
        var questions = [QuestionModel]()
        let tableName: String = "questions_table".localized
        print(tableName)
        do {
            let resultSet:FMResultSet? = try sharedInstance.database?.executeQuery("SELECT * FROM \(tableName) ;", values: nil)
            
            if resultSet != nil {
                while resultSet!.next(){
                    let topicId = Int(resultSet!.int(forColumnIndex: 0))
                    let questionId = Int(resultSet!.int(forColumnIndex: 1))
                    let userAnswerIndex = Int(resultSet!.int(forColumnIndex: 3))
                    
                    if tableName == "questions_table_kir" {
                        let question = resultSet!.string(forColumnIndex: 4)
                        let complexityId = Int(resultSet!.int(forColumnIndex: 8))
                    
                        let answer1 = resultSet!.string(forColumnIndex: 5) ?? ""
                        let answer2 = resultSet!.string(forColumnIndex: 6) ?? ""
                        let answer3 = resultSet!.string(forColumnIndex: 7) ?? ""
                        let answer4 = resultSet!.string(forColumnIndex: 10) ?? ""
                        let answers = [answer1, answer2, answer3, answer4]
                        let rightAnswerInex = Int(resultSet!.int(forColumnIndex: 9))
                        
                        let questionModel = QuestionModel(topicId: topicId, questionId: questionId, question: question!, complexity: complexityId, answers: answers, rightAnswerInex: rightAnswerInex, userAnswerIndex: userAnswerIndex)
                        questions.append(questionModel)
                        
                    } else {
                        let question = resultSet!.string(forColumnIndex: 5)
                        let complexityId = Int(resultSet!.int(forColumnIndex: 9))
                    
                        let answer1 = resultSet!.string(forColumnIndex: 6) ?? ""
                        let answer2 = resultSet!.string(forColumnIndex: 7) ?? ""
                        let answer3 = resultSet!.string(forColumnIndex: 8) ?? ""
                        let answer4 = resultSet!.string(forColumnIndex: 10) ?? ""
                        let answers = [answer1, answer2, answer3, answer4]
                        let rightAnswerInex = Int(resultSet!.int(forColumnIndex: 4))
                        
                        let questionModel = QuestionModel(topicId: topicId, questionId: questionId, question: question!, complexity: complexityId, answers: answers, rightAnswerInex: rightAnswerInex, userAnswerIndex: userAnswerIndex)
                        questions.append(questionModel)
                    }
                }
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
        sharedInstance.database?.close()
        return questions
    }
    
 
    //MARK: Fetching Questions with Filter
    
    func getQuestions(topicID:Int, complexity:Int) -> [QuestionModel]{
        sharedInstance.database?.open()
        var questions = [QuestionModel]()
        let tableName: String = "questions_table".localized
        var comp: String = "complexity"
        if tableName == "questions_table_lat" {
            comp = "complexiy"
        }
        do {
            print(topicID)
            let resultSet:FMResultSet? = try sharedInstance.database?.executeQuery("SELECT * FROM \(tableName) WHERE topic_id = \(topicID) AND \(comp) = \(complexity);", values: nil)
            if resultSet != nil {
                while resultSet!.next(){
                    let topicId = Int(resultSet!.int(forColumnIndex: 0))
                    let questionId = Int(resultSet!.int(forColumnIndex: 1))
                    let userAnswerIndex = Int(resultSet!.int(forColumnIndex: 3))
                    
                    if tableName == "questions_table_kir" {
                        let question = resultSet!.string(forColumnIndex: 4)
                        let complexityId = Int(resultSet!.int(forColumnIndex: 8))
                    
                        let answer1 = resultSet!.string(forColumnIndex: 5) ?? ""
                        let answer2 = resultSet!.string(forColumnIndex: 6) ?? ""
                        let answer3 = resultSet!.string(forColumnIndex: 7) ?? ""
                        let answer4 = resultSet!.string(forColumnIndex: 10) ?? ""
                        let answers = [answer1, answer2, answer3, answer4]
                        let rightAnswerInex = Int(resultSet!.int(forColumnIndex: 9))
                        
                        let questionModel = QuestionModel(topicId: topicId, questionId: questionId, question: question!, complexity: complexityId, answers: answers, rightAnswerInex: rightAnswerInex, userAnswerIndex: userAnswerIndex)
                        questions.append(questionModel)
                        
                    } else {
                        let question = resultSet!.string(forColumnIndex: 5)
                        let complexityId = Int(resultSet!.int(forColumnIndex: 9))
                    
                        let answer1 = resultSet!.string(forColumnIndex: 6) ?? ""
                        let answer2 = resultSet!.string(forColumnIndex: 7) ?? ""
                        let answer3 = resultSet!.string(forColumnIndex: 8) ?? ""
                        let answer4 = resultSet!.string(forColumnIndex: 10) ?? ""
                        let answers = [answer1, answer2, answer3, answer4]
                        let rightAnswerInex = Int(resultSet!.int(forColumnIndex: 4))
                        
                        let questionModel = QuestionModel(topicId: topicId, questionId: questionId, question: question!, complexity: complexityId, answers: answers, rightAnswerInex: rightAnswerInex, userAnswerIndex: userAnswerIndex)
                        questions.append(questionModel)
                    }
                }
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
        sharedInstance.database?.close()
        
        return questions
    }
    
    
    
    func getAllQuestionsByTopic(topicID:Int)->[QuestionModel]{
        sharedInstance.database?.open()
        var questions = [QuestionModel]()
        let tableName: String = "questions_table".localized
        do {
            let resultSet:FMResultSet? = try sharedInstance.database?.executeQuery("SELECT * FROM \(tableName) WHERE topic_id = \(topicID) ;", values: nil)
            
            if resultSet != nil {
                while resultSet!.next() {
                    let topicId = Int(resultSet!.int(forColumnIndex: 0))
                    let questionId = Int(resultSet!.int(forColumnIndex: 1))
                    let learningAnswerIndex = Int(resultSet!.int(forColumnIndex: 2))
                    
                    if tableName == "questions_table_kir" {
                        let question = resultSet!.string(forColumnIndex: 4)
                        let complexityId = Int(resultSet!.int(forColumnIndex: 8))
                    
                        let answer1 = resultSet!.string(forColumnIndex: 5) ?? ""
                        let answer2 = resultSet!.string(forColumnIndex: 6) ?? ""
                        let answer3 = resultSet!.string(forColumnIndex: 7) ?? ""
                        let answer4 = resultSet!.string(forColumnIndex: 10) ?? ""
                        let answers = [answer1, answer2, answer3, answer4]
                        let rightAnswerInex = Int(resultSet!.int(forColumnIndex: 9))
                        
                        let questionModel = QuestionModel(topicId: topicId, questionId: questionId, question: question!, complexity: complexityId, answers: answers, rightAnswerInex: rightAnswerInex, userAnswerIndex: learningAnswerIndex)
                        questions.append(questionModel)
                        
                    } else {
                        let question = resultSet!.string(forColumnIndex: 5)
                        let complexityId = Int(resultSet!.int(forColumnIndex: 9))
                    
                        let answer1 = resultSet!.string(forColumnIndex: 6) ?? ""
                        let answer2 = resultSet!.string(forColumnIndex: 7) ?? ""
                        let answer3 = resultSet!.string(forColumnIndex: 8) ?? ""
                        let answer4 = resultSet!.string(forColumnIndex: 10) ?? ""
                        let answers = [answer1, answer2, answer3, answer4]
                        let rightAnswerInex = Int(resultSet!.int(forColumnIndex: 9))
                        
                        let questionModel = QuestionModel(topicId: topicId, questionId: questionId, question: question!, complexity: complexityId, answers: answers, rightAnswerInex: rightAnswerInex, userAnswerIndex: learningAnswerIndex)
                        questions.append(questionModel)
                    }
                }
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
        sharedInstance.database?.close()
        return questions
    }
    

//MARK: - Updating questions with user answer
    
    func updateExamQuestion(question:QuestionModel,userAnswer:Int)->Bool{
        sharedInstance.database?.open()
        let tableName: String = "questions_table".localized
        let isUpdate = sharedInstance.database?.executeUpdate("UPDATE \(tableName) SET user_answer=? WHERE question_id=?", withArgumentsIn: [userAnswer, question.questionId])
        sharedInstance.database?.close()
        return isUpdate!
    }
    func updateLearningQuestion(question:QuestionModel,userAnswer:Int)->Bool{
        let tableName: String = "questions_table".localized
        sharedInstance.database?.open()
        let isUpdate = sharedInstance.database?.executeUpdate("UPDATE \(tableName) SET learning_answer=? WHERE question_id=?", withArgumentsIn: [userAnswer, question.questionId])
        sharedInstance.database?.close()
        return isUpdate!
    }
    
    func updateallQuestion()->Bool{
        sharedInstance.database?.open()
        let tableName: String = "questions_table".localized
        let isUpdate = sharedInstance.database?.executeUpdate("UPDATE \(tableName) SET user_answer=? ", withArgumentsIn:[0])
        sharedInstance.database?.close()
        return isUpdate!
    }
    
//MARK:- Reset database to initial condidtion
    func resetLearningWithTopicID(topicId:Int){
        let tableName: String = "questions_table".localized
        sharedInstance.database?.open()
        sharedInstance.database?.executeUpdate("UPDATE \(tableName) SET learning_answer=? WHERE topic_id=?", withArgumentsIn: [0,topicId])
        sharedInstance.database?.close()
    }
    
    func resetWithTopicIdComplexity(topicId:Int, complexity:Int){
        sharedInstance.database?.open()
        let tableName: String = "questions_table".localized
        sharedInstance.database?.executeUpdate("UPDATE \(tableName) SET user_answer=? WHERE topic_id=? AND complexity=?", withArgumentsIn: [-1,topicId,complexity])
        sharedInstance.database?.close()
    }
    
    func resetAll(){
        sharedInstance.database?.open()
        let tableName: String = "questions_table".localized
        sharedInstance.database?.executeUpdate("UPDATE \(tableName) SET user_answer=? , learning_answer=?", withArgumentsIn: [-1,0])
        sharedInstance.database?.close()
    }
}
