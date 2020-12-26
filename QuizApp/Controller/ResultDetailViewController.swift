//
//  ResultDetailViewController.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 10/9/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//


import UIKit

class ResultDetailViewController: UIViewController {

 //MARK:- Properties
   
    lazy var  tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableViewCell.identifier)
        tableView.register(AnswerTableViewCell.self, forCellReuseIdentifier: AnswerTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsMultipleSelection = false
        return tableView
    }()

    
    private let question:QuestionModel
    //MARK:-Life Cycle
    
    init(question:QuestionModel){
        self.question = question
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    private func  setupViews() {
        navigationItem.hidesBackButton = false
        view.backgroundColor = #colorLiteral(red: 0.9803171754, green: 0.9804343581, blue: 0.9802773595, alpha: 1)
        view.addSubview(tableView)
        self.tableView.backgroundColor =  #colorLiteral(red: 0.9803171754, green: 0.9804343581, blue: 0.9802773595, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        
    }
}

//MARK:-TableView Datasource and Delegate

extension ResultDetailViewController:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as! QuestionTableViewCell
            
            cell.questionTextLabel.text = question.question
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier:AnswerTableViewCell.identifier, for: indexPath) as! AnswerTableViewCell
           
            cell.configureResultCell(question: question, indexPath: indexPath)
            
            return cell
        }
    
    }
    
}


