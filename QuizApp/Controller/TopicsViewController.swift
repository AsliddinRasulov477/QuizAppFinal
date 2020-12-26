//
//  TopicsViewController.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 10/3/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit
import SQLite3

class TopicsViewController: UIViewController {

    
    lazy var  tableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TopicsTableViewCell.self, forCellReuseIdentifier: TopicsTableViewCell.identifier)
        tableView.estimatedRowHeight = 600
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsMultipleSelection = false
        return tableView
    }()
    
   // var topics:[Topic] = []
    var topics = [TopicModel]()
    
//MARK:-Life Cycle
    private let complexity: Int
    
    init(complexity:Int) {
        self.complexity = complexity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topics = []
        if complexity != 0 {
            for topic in ModelManager.getInstance().getAllTopics() {
                if ModelManager.getInstance().getQuestions(topicID: topic.topic_id , complexity: complexity).count != 0 {
                    topics.append(topic)
                }
            }
            print(topics)
        } else {
            topics = ModelManager.getInstance().getAllTopics()
        }
        
        title = "topics".localized
        tableView.reloadData()
    }
    
    private func setupViews(){
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = false
        view.backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
        view.addSubview(tableView)
        tableView.backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}

extension TopicsViewController:UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopicsTableViewCell.identifier, for: indexPath) as! TopicsTableViewCell
        //cell.topicTextLabel.text = topics[indexPath.row].topic_name
        if complexity == 0 {
            cell.configureLearningCell(topic: topics[indexPath.row])
        }
        else{
            if ModelManager.getInstance().getQuestions(topicID:topics[indexPath.row].topic_id , complexity: complexity).count != 0 {
                cell.configureExamCell(topic: topics[indexPath.row], complexity: complexity)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let topicID = topics[indexPath.row].topic_id
        if complexity == 0 {
            ModelManager.getInstance().resetLearningWithTopicID(topicId: topicID)
            navigationController?.pushViewController(LearningViewController(topicID: topicID), animated: true)
        }else{
            navigationController?.pushViewController(ExamTableViewController(topicID: topicID, complexity: complexity), animated: true)
        }
    }
    
}
