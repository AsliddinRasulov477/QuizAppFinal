//
//  ShadovView.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 11/3/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

class ShadovView:UIView{
    override init(frame:CGRect){
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor =  #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
         layer.cornerRadius = 10
         layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
         layer.shadowOpacity = 1
         layer.shadowOpacity = 1
         layer.shadowRadius = 4
         layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}



class CompletedView:UIView{
    
    lazy var title:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20,weight: .medium)
        return label
    }()
    
    lazy var numberLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        return label
    }()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        addSubview(title)
        addSubview(numberLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor =  #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
         layer.cornerRadius = 10
         layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
         layer.shadowOpacity = 1
         layer.shadowOpacity = 1
         layer.shadowRadius = 4
         layer.shadowOffset = CGSize(width: 1, height: 1)
        
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
    
        numberLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(5)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.centerX.equalToSuperview()
        }
    }
}

class StatisticsView:UIView{
    
    lazy var title:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20,weight: .medium)
        return label
    }()
    
    lazy var numberLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        return label
    }()
    lazy var persentLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        return label
    }()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        addSubview(title)
        addSubview(numberLabel)
        addSubview(persentLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
         backgroundColor = #colorLiteral(red: 0.9763960242, green: 0.9765127301, blue: 0.9763562083, alpha: 1)
         layer.cornerRadius = 10
         layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
         layer.shadowOpacity = 1
         layer.shadowOpacity = 1
         layer.shadowRadius = 4
         layer.shadowOffset = CGSize(width: 1, height: 1)
        
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        numberLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        persentLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
    }
}

class HeaderView:UIView{
    
    lazy var name:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 36,weight: .medium)
        return label
    }()
    
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    override init(frame:CGRect){
        super.init(frame:frame)
        addSubview(imageView)
        addSubview(name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
        
        
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(self.imageView.snp.height)
        }
        imageView.layer.cornerRadius = (self.imageView.frame.height)/2
        
        
        name.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp.right).offset(20)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
    }
}


class SettingHeaderView:UIView{
    
    lazy var name:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 36,weight: .medium)
        return label
    }()
    
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    override init(frame:CGRect){
        super.init(frame:frame)
        addSubview(imageView)
        addSubview(name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
        
        
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(self.imageView.snp.height)
        }
        imageView.layer.cornerRadius = (self.imageView.frame.height)/2
        
        
        name.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp.right).offset(20)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
    }
}




class ContainerView:UIView{
    
    
    lazy var titLe:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    lazy var actionLabel:UILabel = {
        let label = UILabel()
        label.textColor =  #colorLiteral(red: 0.1529411765, green: 0.6823529412, blue: 0.3764705882, alpha: 1)
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        addSubview(titLe)
        addSubview(actionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
      
        
        titLe.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        actionLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(self.titLe.snp.centerY)
        }
         
    }
}
class ExamContainerView:UIView{
    
    
    lazy var titLe:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        addSubview(titLe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //backgroundColor = .secondarySystemBackground
        backgroundColor = .red
        
        titLe.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
       
       
        
        
        
         
    }
}
