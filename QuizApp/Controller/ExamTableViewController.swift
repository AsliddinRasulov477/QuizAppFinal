//
//  QuizTableViewController.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 9/25/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

class ExamTableViewController: UIViewController {

 //MARK:- Properties
   
    var pushed: Bool = false
    
    lazy var  tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableViewCell.identifier)
        tableView.register(AnswerTableViewCell.self, forCellReuseIdentifier: AnswerTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsMultipleSelection = false
        return tableView
    }()
    
    lazy var button:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow"), for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        button.backgroundColor =  #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 1
        button.isHidden = true
        return button
    }()
    
    private func animateButton(){
        DispatchQueue.main.async {
            let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath:"transform.scale")
            scaleAnimation.duration = 0.4
            scaleAnimation.repeatCount = .greatestFiniteMagnitude
            scaleAnimation.autoreverses = true
            scaleAnimation.fromValue = 1.00
            scaleAnimation.toValue = 1.05
            self.button.layer.add(scaleAnimation, forKey:"scale" )
        }
    }
    
    
    
    var questionNumber :Int = 0
    var quizList = [QuestionModel]()
    private let fireworkController = ClassicFireworkController()
   
 //MARK:-Life Cycle
    private let topicID:Int
    private let complexity:Int
     //Init
    init(topicID:Int, complexity:Int){
        self.topicID = topicID
        self.complexity = complexity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if complexity == 0 {
            ModelManager.getInstance().resetLearningWithTopicID(topicId: topicID)
            quizList = ModelManager.getInstance().getAllQuestionsByTopic(topicID: topicID)
        }else{
            quizList = ModelManager.getInstance().getQuestions(topicID: topicID, complexity: complexity)
            print(quizList)
        }
        setupViews()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        button.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func  setupViews() {
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.view.addSubview(button)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
        view.addSubview(tableView)
        self.tableView.backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        button.isHidden = true
        questionNumber = 0
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        button.frame = CGRect(x: view.frame.width-90, y: view.frame.height - (self.view.frame.size.height)*0.1, width: 60, height: 60)
        button.layer.cornerRadius = 30
    }
}

//MARK:-TableView Datasource and Delegate

extension ExamTableViewController:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as! QuestionTableViewCell
            cell.questionNumberlabel.text = "Question: \(questionNumber+1) |  \(quizList.count) "
            cell.questionTextLabel.text = quizList[questionNumber].question
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier:AnswerTableViewCell.identifier, for: indexPath) as! AnswerTableViewCell
            if let answer = quizList[questionNumber].userAnswerIndex {
                if indexPath.row == answer && pushed {
                    cell.roundedView.backgroundColor =  #colorLiteral(red: 0.7294117647, green: 0.7450980392, blue: 0.8, alpha: 1)
                }else{
                    cell.roundedView.backgroundColor =  #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
                }
            }
            cell.configureQuizCell(question: quizList[questionNumber], indexPath: indexPath)
            
            
            return cell
        }
    
    }
   

//MARK: -Single cell selection
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            ModelManager.getInstance().resetWithTopicIdComplexity(topicId: topicID, complexity: complexity)
            self.quizList[questionNumber].userAnswerIndex = indexPath.row
            tableView.reloadData()
            button.isHidden = false
        }
        pushed = true
     //   tableView.reloadData()
    }
    

//MARK: - Actions
    
    @objc private func didTapNextButton(_ sender:AnyObject) {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
        if questionNumber < quizList.count-1{
            questionNumber += 1
            button.isHidden = true
            tableView.allowsSelection = true
            tableView.reloadData()
           
        } else {
            
            if checkAllQuestionSolved(quizList: quizList){
                updateQuiz(quizList: quizList)
                self.tabBarController?.tabBar.isHidden = false
                navigationController?.pushViewController(ResultController(questions: quizList), animated: true)
            }else{
                examFinishedAlert()
            }
            
        }
    }
    
    @objc private func didTapBackButton(){
        if questionNumber > 0 {
            questionNumber -= 1
            tableView.reloadData()
        }
    }
    
//TODO: ALgorithms for quziz tables
    /// Dont push Alert if all quizez are not solved

}

extension ExamTableViewController{
    
    
    func updateQuiz(quizList:[QuestionModel]){
        for q in quizList{
            if  let userAnswer = q.userAnswerIndex {
                let _ = ModelManager.getInstance().updateExamQuestion(question:q, userAnswer: userAnswer)
            }
        }
    }
    
    func examFinishedAlert(){
        let alert = UIAlertController(title: "Warning", message: "To submit your exam you need to solve all question", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func checkAllQuestionSolved(quizList:[QuestionModel])->Bool{
        var solved = true
        for q in quizList{
            if q.userAnswerIndex == 0 {
                solved = false
            }
        }
        return solved
    }
    

}
