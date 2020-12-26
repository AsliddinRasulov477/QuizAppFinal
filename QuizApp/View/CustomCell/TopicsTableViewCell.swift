//
//  TopicsTableViewCell.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 10/3/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit
import SnapKit

class TopicsTableViewCell: UITableViewCell {

    //MARK:-Properties
    
    static let identifier = "TopicsTableViewCell"
    
    lazy var logoImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Vector")
        return imageView
    }()
   
    lazy var topicTextLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Me’yoriy-huquqiy hujjatlarga binoan, qanday hollarda tasdiqlangan hisob siyosatiga o‘zgartirishlar kiritish mumkin"
        return label
    }()
    
    lazy var roundedView:UIView = {
          let view = UIView()
          return view
    }()
    
   lazy var completionImageView:UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFill
       imageView.image = UIImage(named: "true")
       return imageView
   }()
    
    
    //MARK:-Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        
        contentView.backgroundColor = .clear
        roundedView.backgroundColor = #colorLiteral(red: 0.9646322131, green: 0.9647476077, blue: 0.9645928741, alpha: 1)
        selectionStyle = .none
    
        contentView.addSubview(roundedView)
        roundedView.addSubview(logoImageView)
        roundedView.addSubview(topicTextLabel)
        roundedView.addSubview(completionImageView)
        
        roundedView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(5)
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-5)
       }

        logoImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.roundedView.snp.leading).offset(15)
            make.centerY.equalTo(self.roundedView.snp.centerY)
            make.width.equalTo(22)
            make.height.equalTo(24)
        }
        
        
        topicTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.roundedView.snp.top).offset(13)
            make.left.equalTo(self.logoImageView.snp.right).offset(15)
            make.bottom.equalTo(self.roundedView.snp.bottom).offset(-15)
            make.right.equalTo(self.roundedView.snp.right).offset(-35)
            make.height.greaterThanOrEqualTo(60)
        }
        
        
        completionImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.roundedView.snp.bottom).offset(-5)
            make.right.equalTo(self.roundedView.snp.right).offset(-5)
            make.height.equalTo(26)
            make.width.equalTo(26)
        }
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        roundedView.layer.cornerRadius = 10
        roundedView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        roundedView.layer.shadowOpacity = 1
        roundedView.layer.shadowRadius = 4
        roundedView.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    

  //MARK:- Configure Topic Table View cell
    func configureLearningCell(topic:TopicModel){
        topicTextLabel.text = topic.topic_name
        if isFinished(topic: topic){
            completionImageView.isHidden = false
            roundedView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }else{
            completionImageView.isHidden = true
            roundedView.backgroundColor = #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
        }
    }
    
    func configureExamCell(topic:TopicModel, complexity:Int){
        
        topicTextLabel.text = topic.topic_name
        
        if isFinishedComplexity(topic: topic, complexity: complexity){
            completionImageView.isHidden = false
            roundedView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }else{
            completionImageView.isHidden = true
            roundedView.backgroundColor =  #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
        }
    }
    
    
    private func isFinished(topic:TopicModel)->Bool{
        var isfinished = true
        for q in ModelManager.getInstance().getAllQuestionsByTopic(topicID: topic.topic_id){
            if q.userAnswerIndex == 0 {
                isfinished = false
            }
        }
        return isfinished
    }
    
    
    private func isFinishedComplexity(topic:TopicModel, complexity:Int)->Bool{
        var isfinished = true
    
        for q in ModelManager.getInstance().getQuestions(topicID:topic.topic_id , complexity: complexity){
            if q.userAnswerIndex == -1 {
                isfinished = false
            }
        }
        
        return isfinished
    }
    
}
