//
//  ProfileViewController.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 11/9/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

enum StorageType {
    case userDefaults
    case fileSystem
}


class ProfileViewController: UIViewController ,UITextFieldDelegate{

    lazy var imageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .red
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "image")
        image.backgroundColor = .red
        return image
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
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(textField)
        textField.delegate = self
        textField.text = UserDefaults.standard.string(forKey: "userName") ?? ""
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        gesture.numberOfTapsRequired = 1
        
        imageView.addGestureRecognizer(gesture)
        
        display()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }

    @objc func selectImage(){
        self.imagePicker.present()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        

        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.view.frame.size.height/4)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(self.imageView.snp.width)
        }
        imageView.layer.cornerRadius = self.view.frame.size.width * 0.2
       
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.06)
        }
        textField.layer.cornerRadius = self.view.frame.height*0.02
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        if !textField.text!.isEmpty{
            UserDefaults.standard.setValue(textField.text, forKey: "userName")
        }else{
            
        }
       
        return false
    }
    
    
    func display() {
        DispatchQueue.global(qos: .background).async {
            if let savedImage = self.retrieveImage(forKey: "profile",
                                                    inStorageType: .fileSystem) {
                DispatchQueue.main.async {
                    self.imageView.image = savedImage
                }
            }
        }
    }
    
    
    private func store(image: UIImage,
                       forKey key: String,
                       withStorageType storageType: StorageType) {
        if let pngRepresentation = image.pngData() {
            switch storageType {
            case .fileSystem:
                if let filePath = filePath(forKey: key) {
                    do  {
                        try pngRepresentation.write(to: filePath,
                                                    options: .atomic)
                    } catch let err {
                        print("Saving file resulted in error: ", err)
                    }
                }
            case .userDefaults:
                UserDefaults.standard.set(pngRepresentation,
                                          forKey: key)
            }
        }
    }

    
    private func retrieveImage(forKey key: String,
                                inStorageType storageType: StorageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            if let filePath = self.filePath(forKey: key),
                let fileData = FileManager.default.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
        case .userDefaults:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) {
                return image
            }
        }
        
        return nil
    }
    

    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    
}

extension ProfileViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageView.image = image
        if let buildingImage = image {
                DispatchQueue.global(qos: .background).async {
                    self.store(image: buildingImage,
                                forKey: "profile",
                                withStorageType: .fileSystem)
                }
            }
    }
}

