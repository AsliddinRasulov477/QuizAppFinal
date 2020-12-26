//
//  ResultContainer.swift
//  ResultController
//
//  Created by Akhadjon Abdukhalilov on 11/7/20.
//

import UIKit

class ResultContainer:UIView{
    
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var numberLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        return label
    }()
    
    lazy var titLe:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        backgroundColor =  #colorLiteral(red: 0.9803171754, green: 0.9804343581, blue: 0.9802773595, alpha: 1)
        addSubview(imageView)
        addSubview(numberLabel)
        addSubview(titLe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        imageView.snp.makeConstraints { (make) in
            make.right.equalTo(self.titLe.snp.centerX).offset(-5)
            make.top.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalTo(self.imageView.snp.height)
        }
        
        numberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titLe.snp.centerX).offset(5)
            make.centerY.equalTo(self.imageView.snp.centerY)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        titLe.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(5)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
    }
    
}


