//
//  AnswerTableViewCell.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 9/25/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit
import  SnapKit
import QuartzCore

class AnswerTableViewCell: UITableViewCell {
    

//MARK:Properties
    
    static let identifier = "AnswerTableViewCell"
    let  words = ["A", "B", "C", "D"]
    
    lazy var answerTextLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .natural
        return label
    }()
    
    lazy var variantView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 51 / 255.0, green: 196 / 255.0, blue: 129 / 255.0, alpha: 1)
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var variantLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        return label
    }()

    
    lazy var roundedView:UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        view.backgroundColor = #colorLiteral(red: 0.9881597161, green: 0.9882778525, blue: 0.9881196618, alpha: 1)
        return view
    }()
    
    lazy var trueFalseImageView :UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "true")
        imageView.isHidden = true
        return imageView
    }()
    
//MARK:-Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style:style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor.clear
        contentView.backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(animated, animated: animated)
    }
    
    //Cell layer
    override func layoutSubviews() {
        super.layoutSubviews()
        
        roundedView.layer.cornerRadius = 10
        roundedView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        roundedView.layer.shadowOpacity = 1
        roundedView.layer.shadowOpacity = 1
        roundedView.layer.shadowRadius = 4
        roundedView.layer.shadowOffset = CGSize(width: 1, height: 1)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        answerTextLabel.text = nil
    }
    
    private func setupViews(){
        
        contentView.addSubview(roundedView)
        roundedView.addSubview(variantView)
        
        roundedView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(10)
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
        }
        
        variantView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.roundedView.snp.leading).offset(7)
            make.top.equalTo(self.roundedView.snp.top).offset(7)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        variantView.addSubview(variantLabel)
        variantLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.variantView.snp.centerX)
            make.centerY.equalTo(self.variantView.snp.centerY)
        }
        
        //SetupAnswer Lable
        roundedView.addSubview(answerTextLabel)
        answerTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.roundedView.snp.top).offset(14)
            make.bottom.equalTo(self.roundedView.snp.bottom).offset(-32)
            make.leading.equalTo(self.variantView.snp.trailing).offset(16)
            make.trailing.equalTo(self.roundedView.snp.trailing).offset(-36)
            make.height.greaterThanOrEqualTo(60)
        }
        
        roundedView.addSubview(trueFalseImageView)
        trueFalseImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.roundedView.snp.trailing).offset(-8)
            make.bottom.equalTo(self.roundedView.snp.bottom).offset(-5)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
    }
    
    public func configure(with question:QuestionModel, indexPath:IndexPath){
        let id = indexPath.row - 1
        variantLabel.text = words[id]
        answerTextLabel.text = question.answers[id]
    }
    
    func configureResultCell(question:QuestionModel, indexPath:IndexPath){
          
          variantLabel.text = words[indexPath.row - 1]
          answerTextLabel.text = question.answers[indexPath.row - 1]
          
          let  indexPathRow = indexPath.row
          
          if !( question.userAnswerIndex == nil){
              
              if question.rightAnswerInex == question.userAnswerIndex{
                  if indexPathRow == question.rightAnswerInex {
                      roundedView.layer.borderColor = UIColor.green.cgColor
                      trueFalseImageView.isHidden = false
                      trueFalseImageView.image = UIImage(named: "true")
                  }
              }
              else if( indexPathRow == question.rightAnswerInex || indexPathRow == question.userAnswerIndex) {
                  if indexPathRow == question.rightAnswerInex{
                      roundedView.layer.borderColor = UIColor.green.cgColor
                      trueFalseImageView.isHidden = false
                      trueFalseImageView.image = UIImage(named: "true")
                  }else{
                      roundedView.layer.borderColor = UIColor.red.cgColor
                      trueFalseImageView.isHidden = false
                      trueFalseImageView.image = UIImage(named: "false")
                  }
              }else{
                  roundedView.layer.borderColor = UIColor.clear.cgColor
                  trueFalseImageView.isHidden = true
              }
          }
      }

    func configureQuizCell(question:QuestionModel, indexPath:IndexPath){
        variantLabel.text = words[indexPath.row - 1]
        answerTextLabel.text = question.answers[indexPath.row - 1]
    }
}

extension AnswerTableViewCell {
    func shake(duration: CFTimeInterval = 0.3, pathLength: CGFloat = 15) {
        let position: CGPoint = self.center

        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: position.x, y: position.y))
        path.addLine(to: CGPoint(x: position.x-pathLength, y: position.y))
        path.addLine(to: CGPoint(x: position.x+pathLength, y: position.y))
        path.addLine(to: CGPoint(x: position.x-pathLength, y: position.y))
        path.addLine(to: CGPoint(x: position.x+pathLength, y: position.y))
        path.addLine(to: CGPoint(x: position.x, y: position.y))

        let positionAnimation = CAKeyframeAnimation(keyPath: "position")

        positionAnimation.path = path.cgPath
        positionAnimation.duration = duration
        positionAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

        CATransaction.begin()
        self.layer.add(positionAnimation, forKey: nil)
        CATransaction.commit()
    }
}
