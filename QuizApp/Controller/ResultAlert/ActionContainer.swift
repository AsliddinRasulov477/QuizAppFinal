//
//  ActionContainer.swift
//  ResultController
//
//  Created by Akhadjon Abdukhalilov on 11/7/20.
//

import UIKit


class ActionContainer:UIView{
    
    lazy var reviewButton:UIButton = {
        let button = UIButton()
        button.tintColor =  #colorLiteral(red: 0.2027692795, green: 0.7675319314, blue: 0.5035486221, alpha: 1)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        return button
    }()
    
    lazy var homeButton:UIButton = {
        let button = UIButton()
        button.tintColor = #colorLiteral(red: 0.2027692795, green: 0.7675319314, blue: 0.5035486221, alpha: 1)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        return button
    }()
    
    
    override init(frame:CGRect){
        super.init(frame:frame)
        backgroundColor =  #colorLiteral(red: 0.9803171754, green: 0.9804343581, blue: 0.9802773595, alpha: 1)
        addSubview(reviewButton)
        addSubview(homeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
        
        reviewButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        homeButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.reviewButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
       
    }
    

}

