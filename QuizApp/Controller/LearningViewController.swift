//
//  LearningViewController.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 10/24/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit
import AVFoundation

class LearningViewController: UIViewController {

 //MARK:- Properties
   
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.backgroundColor = UIColor(red: 51 / 255.0, green: 196 / 255.0, blue: 129 / 255.0, alpha: 1)
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        button.layer.masksToBounds = false
        button.layer.shadowRadius =  2.0
        button.layer.shadowOpacity = 0.5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    
       
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
    
    lazy var footerView:UIView = {
        let footer = UIView()
        footer.backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
        footer.frame = CGRect(x: 0, y: 0, width:self.view.frame.width, height: 300)
        return footer
    }()
    
    lazy var button:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow"), for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        button.backgroundColor =  UIColor(red: 51 / 255.0, green: 196 / 255.0, blue: 129 / 255.0, alpha: 1)
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
   
    init(topicID:Int){
        self.topicID = topicID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        quizList = ModelManager.getInstance().getAllQuestionsByTopic(topicID: topicID)
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
        view.backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
        view.addSubview(tableView)
        
        self.tableView.backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
      //  self.tableView.tableFooterView = footerView
        
        //footerView.addSubview(nextButton)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionNumber = 0
        button.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.frame = CGRect(x: view.frame.width-90, y: view.frame.height - (self.view.frame.size.height)*0.1, width: 60, height: 60)
        button.layer.cornerRadius = 30
        
        tableView.frame = view.bounds

       
        
    }
}

//MARK:-TableView Datasource and Delegate

extension LearningViewController:UITableViewDelegate, UITableViewDataSource {
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
            cell.configureQuizCell(question: quizList[questionNumber], indexPath: indexPath)
            cell.roundedView.backgroundColor =  #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
//MARK: -Single cell selection
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     //   print(" inside: \(quizList[questionNumber].rightAnswerInex) : index path :\(indexPath.row)")
        if indexPath.row != 0 {
            
            let cell = tableView.cellForRow(at: indexPath) as! AnswerTableViewCell
            self.quizList[questionNumber].userAnswerIndex = indexPath.row
            
            if indexPath.row == quizList[questionNumber].rightAnswerInex{
                
                cell.roundedView.backgroundColor =  UIColor(red: 51 / 255.0, green: 196 / 255.0, blue: 129 / 255.0, alpha: 0.5)
                self.fireworkController.addFireworks(count: 40, sparks: 8, around:cell.roundedView)
                
                UIView.animate(withDuration: 0.3, animations: {
                    cell.roundedView.transform = CGAffineTransform.identity
                }, completion: nil)
                
                UIView.animate(withDuration: 0.15, animations: {
                    cell.roundedView.transform = CGAffineTransform(scaleX: 0.95, y: 0.92)
                }, completion: nil)
                
                UIView.animate(withDuration: 0.3, animations: {
                    cell.roundedView.transform = CGAffineTransform.identity
                }, completion:nil)
                
                
            }else{
               // UIDevice.vibrate()
                cell.roundedView.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.5175226477)
                cell.shake()
            }
            
            button.isHidden = false
            animateButton()
            tableView.allowsSelection = false
            
        }
        
       // nextButton.isHidden = false

    }
    

//MARK: - Actions
    
    @objc private func didTapNextButton(_ sender:AnyObject) {
        tableView.allowsSelection = true
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
        
        if questionNumber < quizList.count-1{
            questionNumber += 1
            button.isHidden = true
            tableView.reloadData()
            
        } else {
            self.button.removeFromSuperview()
            self.tabBarController?.tabBar.isHidden = false
            if checkAllQuestionSolved(quizList: quizList){
                updateQuiz(quizList: quizList)
                navigationController?.pushViewController(ResultController(questions: quizList), animated: true)
            }else{
                examFinishedAlert()
            }
            
        }
    }
    
    
//TODO: ALgorithms for quziz tables
    /// Dont push Alert if all quizez are not solved

}

extension LearningViewController{
    
    
    func updateQuiz(quizList:[QuestionModel]){
        for q in quizList{
            if  let userAnswer = q.userAnswerIndex{
                let _ = ModelManager.getInstance().updateLearningQuestion(question:q, userAnswer: userAnswer)
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

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
