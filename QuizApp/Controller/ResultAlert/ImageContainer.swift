//
//  ImageContainer.swift
//  ResultController
//
//  Created by Akhadjon Abdukhalilov on 11/7/20.
//

import UIKit
import SnapKit



class ImageContainer:UIView{
    
    lazy var titLe:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32,weight: .bold)
        return label
    }()
    
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
    
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var subLabel:UILabel = {
        let label = UILabel()
        label.textColor =  #colorLiteral(red: 0.4391798675, green: 0.4392358959, blue: 0.4391607642, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        backgroundColor =  #colorLiteral(red: 0.9803171754, green: 0.9804343581, blue: 0.9802773595, alpha: 1)
        addSubview(titLe)
        addSubview(imageView)
        addSubview(subLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        
        titLe.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titLe.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(self.imageView.snp.height)
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
    }
}

