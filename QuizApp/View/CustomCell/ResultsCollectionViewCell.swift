//
//  ResultsCollectionViewCell.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 9/27/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

class ResultsCollectionViewCell: UICollectionViewCell {
    
//MARK:Properties
    static let identifier = "ResultsCollectionViewCell"
     
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "true")
        return imageView
    }()
    
    lazy var questionNumberLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "2-savol"
        label.textColor = UIColor(red: 0.108, green: 0.742, blue: 0.133, alpha: 1)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = #colorLiteral(red: 0.9881597161, green: 0.9882778525, blue: 0.9881196618, alpha: 1)
        contentView.addSubview(imageView)
        contentView.addSubview(questionNumberLabel)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        contentView.layer.cornerRadius = 16
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(19)
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.height.equalTo(26)
            make.width.equalTo(26)
        }
        
        questionNumberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(8)
            make.centerX.equalTo(self.contentView.snp.centerX)
            
        }
        
    }
    
    
    
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        questionNumberLabel.text = nil
    }
    
   func congiureCell(with Question:QuestionModel){
        if Question.rightAnswerInex != Question.userAnswerIndex{
            imageView.image = UIImage(named: "false")
            questionNumberLabel.textColor = .red
        }else{
            imageView.image = UIImage(named: "true")
            questionNumberLabel.textColor = UIColor(red: 0.108, green: 0.742, blue: 0.133, alpha: 1)
        }
    }
    
    
}

