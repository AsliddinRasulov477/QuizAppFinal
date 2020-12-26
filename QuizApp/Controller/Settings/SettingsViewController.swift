//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 9/25/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.


import UIKit
import SnapKit

class SettingsViewController: UIViewController {

    var menus:[String] = ["1".localized, "2".localized, "3".localized, "4".localized,"5".localized,"6".localized, "reset".localized]
    let images = ["lanselection","darkmode", "share","rate","aboutUs","otherApps","otherApps"]
    
    
    lazy var headerView: HeaderView = {
        let header = HeaderView()
        header.name.text = "Hi, Tony!"
        header.imageView.backgroundColor = UIColor(red: 51 / 255.0, green: 196 / 255.0, blue: 129 / 255.0, alpha: 0.5)
        header.imageView.image = UIImage(named: "image")
        header.imageView.contentMode = .scaleAspectFit
        return header
    }()
    
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
       // tableView.separatorStyle = .none
        tableView.backgroundColor =  #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor =  #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
      
        setupViews()
        applyTheme()
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        title = "setting".localized
        menus = ["1".localized, "2".localized, "3".localized, "4".localized,"5".localized,"6".localized,"reset".localized]
        tableView.reloadData()
        display()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.topMargin)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
    
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        headerView.imageView.layer.cornerRadius = self.headerView.imageView.frame.width/2
    }
    
    private func setupViews(){
        view.addSubview(headerView)
        view.addSubview(tableView)
        headerView.imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(editProfile))
        gesture.numberOfTapsRequired = 1
       
        headerView.addGestureRecognizer(gesture)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    @objc func editProfile(){
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    
    fileprivate func applyTheme(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:Theme.current.fontColor]
    }
}

extension SettingsViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
        
        cell.titleLabel.text = menus[indexPath.row]
        cell.imageview.image = UIImage(named: images[indexPath.row])
        
        if indexPath.row == 1 {
            cell.delegate = self
            cell.switcher.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let vc = LanguageViewController()
            navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 5 {
            navigationController?.pushViewController(OurAppViewController(), animated: true)
        }
        else if indexPath.row == 6{
            ModelManager.getInstance().resetAll()
            
            if let tab = tabBarController  {
                tab.selectedIndex = 0
                if let navcon = tab.selectedViewController as? UINavigationController {
                    navcon.popToRootViewController(animated: true)
                }
            }
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
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
    func display() {
        DispatchQueue.global(qos: .background).async {
            let savedImage = self.retrieveImage(forKey: "profile", inStorageType: .fileSystem)
        
            let userName = UserDefaults.standard.string(forKey: "userName") ?? ""
            
            do {
                DispatchQueue.main.async {
                    self.headerView.imageView.image = savedImage ?? UIImage(named: "image")
                    self.headerView.name.text = "Hi".localized + ", " + userName + "!"
                }
            }
        }
    }

}

extension SettingsViewController:SettingCellDelegate{    
    func didTapChangeTheme(sender:UISwitch) {
        if sender.isOn {
            Theme.current = LightTheme()
        }else{
            Theme.current = DarkTheme()
        }
        applyTheme()
        tableView.reloadData()
    }
}


