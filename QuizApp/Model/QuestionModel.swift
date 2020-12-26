//
//  QuestionModel.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 10/10/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import Foundation


struct QuestionModel {
    var topicId:Int
    var questionId:Int
    var question:String
    var complexity:Int
    var answers:[String]
    var rightAnswerInex:Int
    var userAnswerIndex:Int?
}
