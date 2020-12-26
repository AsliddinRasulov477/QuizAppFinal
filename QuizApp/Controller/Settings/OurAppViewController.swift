//
//  OurAppViewController.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 10/28/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit
import SafariServices

struct App{
    let name:String
    let description:String
    let appUrl:String
    let imageName:String
}

class OurAppViewController: UIViewController{

    //MARK:Properties
    
    let ourApps:[App] = [App(name: "plan_schotov", description: "Эта программа бухгалтерского учета и быстро получить информацию из      некоторых...", appUrl: "https://www.apple.com/itunes/",imageName: "app1"),
                         App(name: "bxms", description: "В приложении пользователь имеет доступ ко всем Национальным Стандартам Бухгалтерского учета...", appUrl: "https://www.apple.com/itunes/",imageName: "app2"),
                         App(name: "svod_zakonov", description: "Приложение - список кодексов. Пользователь может ознакомиться и выбрать нужные...", appUrl: "https://www.apple.com/itunes/",imageName: "app3"),
                         App(name: "Бухгалтерские проводки", description: "Эта программа бухгалтерского учета и быстро получить информацию из некоторых...", appUrl: "https://www.apple.com/itunes/", imageName: "app4")]
    
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(OurAppsTableViewCell.self, forCellReuseIdentifier: OurAppsTableViewCell.identifier)
        tableView.backgroundColor =  #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Our Apps"
        view.addSubview(tableView)
        tableView.backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

}

extension OurAppViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ourApps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OurAppsTableViewCell.identifier, for: indexPath) as! OurAppsTableViewCell
        cell.configureAppsCell(app: ourApps[indexPath.row])
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}

extension OurAppViewController:OurAppsTableViewCellDelegate{
    
    func didTapAppStore(app: App) {
        guard  let url = URL(string:app.appUrl) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    

}
