//
//  SettingCell.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 10/8/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

protocol SettingCellDelegate:AnyObject {
    func didTapChangeTheme(sender:UISwitch)
}

class SettingCell: UITableViewCell{

//MARK:-Properties
    static let identifier = "SettingCell"
    weak var delegate:SettingCellDelegate?
    
    lazy var imageview :UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "infoIcon")
        image.layer.cornerRadius = 5
        return image
    }()
    
    lazy var titleLabel :UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var switcher:UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        switcher.isHidden = true
        switcher.addTarget(self, action: #selector(changeTheme), for: .valueChanged)
        return switcher
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor =  #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
       
        
        contentView.addSubview(imageview)
        contentView.addSubview(titleLabel)
        contentView.addSubview(switcher)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

        imageview.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.contentView.snp.left).offset(35)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageview.snp.right).offset(25)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        switcher.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.right.equalTo(self.contentView.snp.right).offset(-35)
        }
        
    }
    
    
    //MARK:Actions
    
    @objc private func changeTheme(sender:UISwitch){
        delegate?.didTapChangeTheme(sender: sender)
    }
}
