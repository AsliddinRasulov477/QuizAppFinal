//
//  CustomButton.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 10/5/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.


import UIKit

class CustomButton: UIButton {

    lazy var title:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(title)
        backgroundColor = #colorLiteral(red: 0.9803171754, green: 0.9804343581, blue: 0.9802773595, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
         layer.cornerRadius = 16
         layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
         layer.shadowOpacity = 1
         layer.shadowOpacity = 1
         layer.shadowRadius = 4
         layer.shadowOffset = CGSize(width: 5, height: 5)

        title.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
}

class ComplexityButton: UIButton {
    
    lazy var level:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    lazy var question:UILabel = {
        let label = UILabel()
        label.text = "questions"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var number:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame:frame)
       
        addSubview(level)
        addSubview(number)
        addSubview(question)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
         layer.cornerRadius = 10
         layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
         layer.shadowOpacity = 1
         layer.shadowOpacity = 1
         layer.shadowRadius = 4
         layer.shadowOffset = CGSize(width: 1, height: 1)

        
        
        level.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(layer.frame.width/4)
            make.centerY.equalToSuperview()
        }
        
        question.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
        number.snp.makeConstraints { (make) in
            make.right.equalTo(self.question.snp.left).offset(-20)
            make.centerY.equalToSuperview()
        }
        
        
    }
    
}
