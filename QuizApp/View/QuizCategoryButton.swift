//
//  CustomButton.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 9/24/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

class QuizCategoryButton: UIButton {
    
    
    lazy var title:UILabel = {
              let label = UILabel()
              label.textAlignment = .center
              return label
       }()
       
       override init(frame: CGRect) {
           super.init(frame:frame)
           addSubview(title)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowOpacity = 4.0
        layer.masksToBounds = false
        layer.cornerRadius = 15
       // backgroundColor = .blue
        
        title.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(5)
            make.right.equalTo(self.snp.right).offset(5)
        }
    }
}


class ShadowButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowOpacity = 4.0
        layer.masksToBounds = false
        layer.cornerRadius = 15
    }

}
