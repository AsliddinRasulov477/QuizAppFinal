//
//  QuestionTableViewCell.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 9/25/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    
//MARK:-Properties
    
    static let identifier = "QuestionTableViewCell"
    
    lazy var questionNumberlabel :UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Question #1"
        return label
    }()
    
    lazy var questionTextLabel :UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = #colorLiteral(red: 0.9646322131, green: 0.9647476077, blue: 0.9645928741, alpha: 1)
        selectionStyle = .none
        contentView.addSubview(questionNumberlabel)
        questionNumberlabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(15)
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.height.equalTo(20)
        }
        //configure label
        contentView.addSubview(questionTextLabel)
        questionTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.questionNumberlabel.snp.top).offset(20)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
            make.leading.equalTo(self.contentView.snp.leading).offset(57)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-36)
            make.height.greaterThanOrEqualTo(80)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        questionTextLabel.text = nil
    }

}
