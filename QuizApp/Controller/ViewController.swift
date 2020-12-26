//
//  ViewController.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 9/23/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit
import SnapKit

class QuizViewController: UIViewController {

    
//MARK:-Properties
    
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .secondarySystemBackground
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    lazy var questionNmuber:UILabel = {
        let label = UILabel()
        label.text = "10"
        return label
    }()
    
    lazy var textField :QuestionTextView = {
        let text = QuestionTextView()
        text.font = UIFont.systemFont(ofSize: 18)
       // text.backgroundColor = .red
        return text
    }()
    
    lazy var buttonA:AnswerButton = {
        let button = AnswerButton()
        button.setTitle("this is just test option", for: .normal)
        return button
    }()
    lazy var buttonB:AnswerButton = {
        let button = AnswerButton()
        button.setTitle("this is just test option", for: .normal)
        return button
    }()
    lazy var buttonC:AnswerButton = {
        let button = AnswerButton()
        button.setTitle("this is just test option", for: .normal)
        return button
    }()
    lazy var buttonD:AnswerButton = {
        let button = AnswerButton()
        button.setTitle("this is just test option", for: .normal)
        return button
    }()
    
    lazy var submitButton:SubmitButton = {
        let buttton = SubmitButton()
        buttton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        buttton.setTitle("Submit", for: .normal)
        buttton.backgroundColor = .red
        buttton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        return buttton
    }()
    
    
    
    
 //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
       
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(nextButton)
        scrollView.addSubview(questionNmuber)
        scrollView.addSubview(textField)
        scrollView.addSubview(buttonA)
        scrollView.addSubview(buttonB)
        scrollView.addSubview(buttonC)
        scrollView.addSubview(buttonD)
        scrollView.addSubview(submitButton)
        
    }
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height + 100)
        textField.text = "Automatically assigning platform `iOS` with version `13.4` on target `QuizApp` because no platform was specified. Please specify a platform for this target in your Podfile. See `https://guides.cocoapods.org/syntax/podfile"
        
        scrollView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        questionNmuber.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.left.equalTo(scrollView.snp.left).offset(10)
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(questionNmuber.snp.bottom).offset(25)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.5)
        }
        
        buttonA.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.2)
        }
        buttonB.snp.makeConstraints { (make) in
            make.top.equalTo(buttonA.snp.bottom).offset(20)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.2)
        }
        buttonC.snp.makeConstraints { (make) in
            make.top.equalTo(buttonB.snp.bottom).offset(20)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.2)
        }
        buttonD.snp.makeConstraints { (make) in
            make.top.equalTo(buttonC.snp.bottom).offset(20)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.2)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(buttonD.snp.bottom).offset(20)
            make.left.equalTo(self.view.snp.left).offset(50)
            make.right.equalTo(self.view.snp.right).offset(-40)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.15)
            
        }
    
    }
    
    
    
 //MARK:-Actions
    
    @objc func didTapSubmitButton(){
       
        textField.text = "When the bounds change for a view controller's view, the view adjusts the positions of its subviews and then the system calls this method. However, this method being called does not indicate that the individual layouts of the view's subviews have been adjusted. Each subview is responsible for adjusting its own layout."
         buttonA.titleLabel?.text = "he system calls this method"
         buttonB.titleLabel?.text = "subviews have been adjusted"
         buttonC.titleLabel?.text = "Each subview is responsible"
         buttonD.titleLabel?.text =  "then the system calls this method"
        
    }


}

