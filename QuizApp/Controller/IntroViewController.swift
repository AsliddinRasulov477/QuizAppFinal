//
//  IntroViewController.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 11/12/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController ,UITextFieldDelegate{
    //MARK:-Properties
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 46,weight: .bold)
        label.text = "Digital World"
        return label
    }()
    
    lazy var signUpLabel:UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4391798675, green: 0.4392358959, blue: 0.4391607642, alpha: 1)
        label.text = "Sign Up"
        label.font = UIFont.systemFont(ofSize: 32,weight: .bold)
        return label
    }()
    
    lazy var subLabel :UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4391798675, green: 0.4392358959, blue: 0.4391607642, alpha: 1)
        label.text = "Developed by Digital World"
        label.textAlignment = .center
        return label
    }()
    
    lazy var textField:UITextField = {
        let textfield = UITextField()
        textfield.leftViewMode = .always
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textfield.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        textfield.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        textfield.layer.shadowOpacity = 1
        textfield.layer.shadowOpacity = 1
        textfield.layer.shadowRadius = 4
        textfield.layer.shadowOffset = CGSize(width: 1, height: 1)
        textfield.placeholder = "Enter your username"
        textfield.autocapitalizationType = .words
        textfield.autocorrectionType = .no
        textfield.returnKeyType = .continue
        return textfield
    }()
    
    lazy var button:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow"), for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        button.backgroundColor =  #colorLiteral(red: 0.2027692795, green: 0.7675319314, blue: 0.5035486221, alpha: 1)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 1
        button.isHidden = true
        return button
    }()
    
    lazy var background:UIImageView = {
        let background = UIImageView()
        background.image = UIImage(named: "Group")
        background.contentMode = .scaleAspectFill
        return background
    }()
    
    private func animateButton(){
        DispatchQueue.main.async {
            let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath:"transform.scale")
            scaleAnimation.duration = 0.4
            scaleAnimation.repeatCount = .greatestFiniteMagnitude
            scaleAnimation.autoreverses = true
            scaleAnimation.fromValue = 1.00
            scaleAnimation.toValue = 1.05
            self.button.layer.add(scaleAnimation, forKey:"scale" )
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.9803171754, green: 0.9804343581, blue: 0.9802773595, alpha: 1)
        view.addSubview(background)
        view.addSubview(titleLabel)
        view.addSubview(signUpLabel)
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(subLabel)
        textField.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        background.frame = view.bounds
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.view.frame.size.height * 0.15)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.left.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        
        signUpLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.06)
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(self.signUpLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.06)
        }
        textField.layer.cornerRadius = self.view.frame.height*0.02
        
        button.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-(self.view.frame.size.height * 0.2))
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        button.layer.cornerRadius = 35
        
        subLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        if !textField.text!.isEmpty{
            button.isHidden = false
            animateButton()
        }else{
            button.isHidden = true
        }
       
        return false
    }
    
    
    //MARK:-Actions
    @objc
    func didTapNextButton(){
        
        if let userName = textField.text{
            UserDefaults.standard.set(userName, forKey: "userName")
        }
        dismiss(animated:false, completion: nil)
        
    }


}
