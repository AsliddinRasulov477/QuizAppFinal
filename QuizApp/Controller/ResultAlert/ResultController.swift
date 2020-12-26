//
//  ViewController.swift
//  ResultController
//
//  Created by Akhadjon Abdukhalilov on 11/7/20.
//

import UIKit

class ResultController: UIViewController {

    //MARK:-Prorerties
    
    lazy var header:ImageContainer = {
        let header = ImageContainer()
        header.imageView.image = UIImage(named: "image")
        header.titLe.text = "Result"
        header.subLabel.text = "You have successfully finished the quiz!"
        return header
    }()
    
    lazy var correctView:ResultContainer={
        let view = ResultContainer()
        view.imageView.image = UIImage(named: "true")
        view.numberLabel.text = "15"
        view.titLe.text = "Correct"
        return view
    }()
    lazy var skippedView:ResultContainer={
        let view = ResultContainer()
        view.imageView.image = UIImage(named: "skipped")
        view.numberLabel.text = "0"
        view.titLe.text = "Skipped"
        return view
    }()
    lazy var incorrectView:ResultContainer={
        let view = ResultContainer()
        view.imageView.image = UIImage(named: "false")
        view.numberLabel.text = "20"
        view.titLe.text = "InCorrect"
        return view
    }()
    
    lazy var actionView:ActionContainer = {
        let view = ActionContainer()
        view.reviewButton.setTitle("Review", for: .normal)
        view.homeButton.setTitle("Back to home", for: .normal)
        view.homeButton.addTarget(self, action: #selector(didTapbackToHomeButton), for: .touchUpInside)
        view.reviewButton.addTarget(self, action: #selector(didTapShowQuizAnswersButton), for: .touchUpInside)
        return view
    }()
    
    
    private let quizList:[QuestionModel]
    //MARK:-Life Cycle
    
    init(questions:[QuestionModel]){
        self.quizList = questions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9803171754, green: 0.9804343581, blue: 0.9802773595, alpha: 1)

        view.addSubview(header)
        view.addSubview(correctView)
        view.addSubview(skippedView)
        view.addSubview(incorrectView)
        view.addSubview(actionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure(with: quizList)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        header.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.topMargin)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        skippedView.snp.makeConstraints { (make) in
            make.top.equalTo(self.header.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.12)
            make.width.equalToSuperview().multipliedBy(0.31)
        }
        correctView.snp.makeConstraints { (make) in
            make.top.equalTo(self.header.snp.bottom)
            make.right.equalTo(self.skippedView.snp.left)
            make.height.equalToSuperview().multipliedBy(0.12)
            make.width.equalToSuperview().multipliedBy(0.31)
        }
        incorrectView.snp.makeConstraints { (make) in
            make.top.equalTo(self.header.snp.bottom)
            make.left.equalTo(self.skippedView.snp.right)
            make.height.equalToSuperview().multipliedBy(0.12)
            make.width.equalToSuperview().multipliedBy(0.31)
        }
        actionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.skippedView.snp.bottom)
            make.self.right.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
    
    private func configure(with questions:[QuestionModel]){
        var skipped = 0
        var correct = 0
        var incorrect = 0
        for question in questions{
            if question.userAnswerIndex == 0{
                skipped += 1
            } else if question.userAnswerIndex == question.rightAnswerInex{
                correct += 1
            }else{
                incorrect += 1
            }
        }
        
        correctView.numberLabel.text = String(correct)
        incorrectView.numberLabel.text = String(incorrect)
        skippedView.numberLabel.text = String(skipped)
        
        if correct > incorrect{
            header.imageView.image = UIImage(named: "image")
            header.subLabel.text = "You have successfully finished the quiz!"
        }else{
            header.imageView.image = UIImage(named: "image2")
            header.subLabel.text = "It is ok. Next time you will do your best"
        }
        
    }
    
    
    //MARK:-Actions

    
    @objc func didTapShowQuizAnswersButton(){
        navigationController?.pushViewController(ResultsViewController(questions: quizList), animated: true)
    }
    
    @objc func didTapbackToHomeButton(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}

