//
//  OurAppsTableViewCell.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 10/28/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit
protocol OurAppsTableViewCellDelegate:AnyObject{
    func didTapAppStore(app:App)
}
class OurAppsTableViewCell: UITableViewCell {

    //MARK:-Properties
    static let identifier = "OurAppsCell"
    weak var delegate:OurAppsTableViewCellDelegate?
    private var app:App?
    
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
        label.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        label.textColor = #colorLiteral(red: 0.2, green: 0.768627451, blue: 0.5058823529, alpha: 1)
        return label
    }()
    
    lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var appStoresImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "AppStore")
        image.isUserInteractionEnabled = true
        return image
    }()
    
    override var frame: CGRect {
            get {
                return super.frame
            } set (newFrame) {
                textLabel?.numberOfLines = 0
                var frame = newFrame
                frame.origin.x += 10
                frame.size.width -= 20
                frame.origin.y += 5
                frame.size.height -= 10
                super.frame = frame
            }
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor =  #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
        contentView.addSubview(imageview)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(appStoresImageView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapAppStore))
        gesture.numberOfTapsRequired = 1
        appStoresImageView.addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        backgroundColor =  #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
        selectionStyle = .none
        
        layer.cornerRadius = 16
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 5, height: 5)
        
        imageview.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(14)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(self.imageview.snp.right).offset(14)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.left.equalTo(self.imageview.snp.right).offset(14)
            make.right.equalToSuperview().offset(-12)
        }
        
        appStoresImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-14)
            make.height.equalTo(30)
        }
    }
    
    func configureAppsCell(app:App){
        self.app = app
        titleLabel.text = app.name
        descriptionLabel.text = app.description
        imageview.image = UIImage(named: app.imageName)
        
    }
    
    
    @objc func  didTapAppStore(){
        guard let app = app else { return }
        delegate?.didTapAppStore(app: app)
    
    }
}
