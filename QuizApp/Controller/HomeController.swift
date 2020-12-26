//
//  Homeontroller.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 11/3/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    //MARK:Properties
    lazy var headerView: HeaderView = {
        let header = HeaderView()
        header.name.text = "Hi, Tony!"
        header.imageView.backgroundColor = UIColor(
            red: 51 / 255.0, green: 196 / 255.0, blue: 129 / 255.0, alpha: 0.5
        )
        header.imageView.image = UIImage(named: "image")
        header.imageView.contentMode = .scaleAspectFit
        return header
    }()
    lazy var circularProgressView:StatisticsView = {
         let view = StatisticsView()
         view.title.text = "Total test"
         view.numberLabel.text = "1242/2800"
        view.persentLabel.text = "70%"
         return view
     }()
    
    lazy var compltedView:CompletedView = {
         let view = CompletedView()
         view.title.text = "Completed"
         view.numberLabel.text = "23"
         return view
     }()
    
    lazy var inCompltedView:CompletedView = {
        let view = CompletedView()
        view.title.text = "InCompleted"
        view.numberLabel.text = "23"
        return view
     }()
    lazy var segmentControl :UISegmentedControl = {
        let control = UISegmentedControl(items: ["Learning","Exam"])
        control.selectedSegmentIndex = 0
        control.layer.borderWidth = 1
        control.layer.borderColor = UIColor.white.cgColor
        if #available(iOS 13.0, *) {
            control.selectedSegmentTintColor = UIColor(red: 51 / 255.0, green: 196 / 255.0, blue: 129 / 255.0, alpha: 0.6)
        } else {
           
        }
        control.addTarget(self, action: #selector(handleSegmentControlValueChange(_ :)), for: .valueChanged)
        return control
    }()
    
    lazy var learningContainer:ContainerView = {
        let view = ContainerView()
        view.titLe.text = "Learning"
        view.actionLabel.text = "See all >"
        return view
    }()
    
    lazy var examContainer:ContainerView = {
        let view = ContainerView()
        view.titLe.text = "Level of difficulty"
        view.backgroundColor = .yellow
        view.isHidden = true
        return view
    }()
    
    lazy var  tableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TopicsTableViewCell.self, forCellReuseIdentifier: TopicsTableViewCell.identifier)
        tableView.estimatedRowHeight = 600
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    lazy var easy:ComplexityButton = {
        let button = ComplexityButton()
        button.backgroundColor = #colorLiteral(red: 0.8436079621, green: 0.9999470115, blue: 0.8111748695, alpha: 1)
        button.level.text = "Easy"
        button.number.text = "123"
        button.addTarget(self, action: #selector(easyLevelSelected), for: .touchUpInside)
        return button
    }()
    lazy var normal:ComplexityButton = {
        let button = ComplexityButton()
        button.backgroundColor = #colorLiteral(red: 0.9871397614, green: 0.9390335083, blue: 0.7342716455, alpha: 1)
        button.level.text = "Normal"
        button.addTarget(self, action: #selector(mediumLevelSelected), for: .touchUpInside)
        button.number.text = "123"
        return button
    }()
    lazy var hard:ComplexityButton = {
        let button = ComplexityButton()
        button.backgroundColor = #colorLiteral(red: 0.9829561114, green: 0.8419747949, blue: 0.8445328474, alpha: 1)
        button.level.text = "Hard"
        button.addTarget(self, action: #selector(hardLevelSelected), for: .touchUpInside)
        button.number.text = "123"
        return button
    }()

    lazy var image:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "easyshape")
        return image
    }()
    lazy var image2:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "normalshape")
        return image
    }()
    lazy var image3:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "difficultshape")
        return image
    }()

    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    var circularView = UIView()
    var topics = [TopicModel]()
    var imagePicker: ImagePicker!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        topics = []
        topics = ModelManager.getInstance().getAllTopics()
        
        
        let swiperight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(HomeController.swiperight(gestureRecognizer:)))
        swiperight.direction = .right
        self.view!.addGestureRecognizer(swiperight)
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(HomeController.swipeLeft(gestureRecognizer:)))
        swipeLeft.direction = .left
        self.view!.addGestureRecognizer(swipeLeft)
        
        let seeAll = UITapGestureRecognizer(target: self, action:#selector(seeAllTopics))
        seeAll.numberOfTapsRequired = 1
        learningContainer.actionLabel.addGestureRecognizer(seeAll)
        setupViews()
        
        if UserDefaults.standard.string(forKey: "userName") == nil {
            let vc = IntroViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: true)
        }
        
        circularView = UIView(frame: circularProgressView.bounds)
       
        self.navigationController?.isNavigationBarHidden = true
       // navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.tabBar.isHidden = false
        locaLizeHome()
        configureHome()
        
        tableView.reloadData()
        display()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 51 / 255.0, green: 196 / 255.0, blue: 129 / 255.0, alpha: 1)
        tabBarController?.tabBar.barTintColor = UIColor(red: 51 / 255.0, green: 196 / 255.0, blue: 129 / 255.0, alpha: 1)
        
        navigationController?.navigationBar.tintColor = .white
        tabBarController?.tabBar.tintColor = .white
    }
    
    private func setupViews(){
        
        view.backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
        self.navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(headerView)
        view.addSubview(circularProgressView)
        view.addSubview(compltedView)
        view.addSubview(inCompltedView)
        view.addSubview(segmentControl)
        
        view.addSubview(learningContainer)
        view.addSubview(examContainer)
        examContainer.addSubview(easy)
        easy.addSubview(image)
        examContainer.addSubview(normal)
        normal.addSubview(image2)
        examContainer.addSubview(hard)
        hard.addSubview(image3)
        learningContainer.addSubview(tableView)
    
    }
    
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
        circularView.frame = circularProgressView.bounds
        circularView.createCircularPath(circleLayer: circleLayer, progressLayer: progressLayer)
        circularView.center = circularProgressView.center
        view.addSubview(circularView)
    }

    
    
    //MARK:-Actions
    @objc private func handleSegmentControlValueChange(_ sender:UISegmentedControl){
        
        switch sender.selectedSegmentIndex {
        case 0 :
            learningContainer.isHidden = false
            examContainer.isHidden = true
            
        case 1:
            examContainer.isHidden = false
            learningContainer.isHidden = true
        default:
            return
        }
    }
    
    
    @objc func swiperight(gestureRecognizer: UISwipeGestureRecognizer) {
        if segmentControl.selectedSegmentIndex == 1{
           segmentControl.selectedSegmentIndex = 0
            learningContainer.isHidden = false
            examContainer.isHidden = true
        }
        
    }
    
    @objc func swipeLeft(gestureRecognizer: UISwipeGestureRecognizer) {
        if segmentControl.selectedSegmentIndex == 0 {
            segmentControl.selectedSegmentIndex = 1
            examContainer.isHidden = false
            learningContainer.isHidden = true
           
        }
    }
    
    @objc private func seeAllTopics(){
        navigationController?.pushViewController(TopicsViewController(complexity: 0), animated: true)
    }
    
    @objc private func easyLevelSelected(){
        navigationController?.pushViewController(TopicsViewController(complexity: 1),animated: true)
    }
    
    @objc private func mediumLevelSelected(){
        navigationController?.pushViewController(TopicsViewController(complexity: 2), animated: true)
    }
    
    @objc private func hardLevelSelected(){
        navigationController?.pushViewController(TopicsViewController(complexity: 3), animated: true)
    }
    
    
    private func locaLizeHome(){
        headerView.name.text = "Hi".localized + ", " + "Tony!"
        circularProgressView.title.text = "TotalTest".localized
        compltedView.title.text = "Completed".localized
        inCompltedView.title.text = "InCompleted".localized
        segmentControl.setTitle("Learning".localized, forSegmentAt: 0)
        segmentControl.setTitle("Exam".localized, forSegmentAt: 1)
        learningContainer.titLe.text = "Learning".localized
        learningContainer.actionLabel.text = "See All".localized
        examContainer.titLe.text = "LevelOfDifficulty".localized
        
        easy.level.text = "Easy".localized
        easy.question.text = "questions".localized
        normal.level.text = "Normal".localized
        normal.question.text = "questions".localized
        hard.level.text = "Hard".localized
        hard.question.text = "questions".localized
    }
    
   
    
    private func configureHome() {
        
        var numberOfAllQuestion = 0
        var numberOfSolvedQuestion = 0
        var completedTopics = 0
        var incompltedTopics = 0
        var persent = 0
        var easyQuestionsCount = 0
        var normalQuestionsCount = 0
        var hardQuestionsCount = 0
        
    
        numberOfAllQuestion = ModelManager.getInstance().getAllQuestions().count

        for q in ModelManager.getInstance().getAllQuestions(){

            if q.userAnswerIndex == q.rightAnswerInex{
                numberOfSolvedQuestion += 1
            }
            if q.complexity == 1 {
                easyQuestionsCount += 1
            }
            if q.complexity == 2 {
                normalQuestionsCount += 1
            }
            if q.complexity == 3 {
                hardQuestionsCount += 1
            }

        }
        
        for topic in ModelManager.getInstance().getAllTopics(){
            if isFinished(topic: topic){
                completedTopics += 1
            }else{
                incompltedTopics += 1
            }
        }
        
        circularView.progressAnimation(progressLayer: progressLayer, duration: 0.3, value: Float(numberOfSolvedQuestion)/Float(numberOfAllQuestion))
        persent = numberOfSolvedQuestion*100/numberOfAllQuestion
        
    
        circularProgressView.persentLabel.text = String(persent)+"%"
        circularProgressView.numberLabel.text = String(numberOfSolvedQuestion) + "/" + String(numberOfAllQuestion)
        compltedView.numberLabel.text = String(completedTopics)
        inCompltedView.numberLabel.text = String(incompltedTopics)
        
        easy.number.text = String(easyQuestionsCount)
        normal.number.text = String(normalQuestionsCount)
        hard.number.text = String(hardQuestionsCount)
    }
    
    func isFinished(topic: TopicModel)->Bool{
          var isfinished = true

          for q in ModelManager.getInstance().getAllQuestionsByTopic(topicID: topic.topic_id){
              if q.userAnswerIndex == 0 {
                  isfinished = false
              }
          }
          return isfinished
      }
    
    
    
    private func setupConstraints(){
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.topMargin)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.92)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.08)
        }
        circularProgressView.frame = CGRect(x: self.view.frame.width * 0.04, y: self.view.safeAreaInsets.top + view.frame.height * 0.08, width: self.view.frame.width * 0.44, height: self.view.frame.height * 0.23)
       
        compltedView.snp.makeConstraints { (make) in
            make.top.equalTo(self.circularProgressView.snp.top)
            make.right.equalTo(self.headerView.snp.right)
            make.width.equalToSuperview().multipliedBy(0.44)
            make.height.equalTo(self.circularProgressView.snp.height).multipliedBy(0.47)
        }
        inCompltedView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.circularProgressView.snp.bottom)
            make.right.equalTo(self.headerView.snp.right)
            make.width.equalToSuperview().multipliedBy(0.44)
            make.height.equalTo(self.circularProgressView.snp.height).multipliedBy(0.47)
        }
        
        segmentControl.snp.makeConstraints { (make) in
            make.top.equalTo(self.circularProgressView.snp.bottom).offset(15)
            make.width.equalTo(self.headerView.snp.width)
            make.height.equalToSuperview().multipliedBy(0.04)
            make.centerX.equalToSuperview()
        }
        
        ///Learning
        learningContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self.segmentControl.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.snp_bottomMargin)
        }
    
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(45)
            make.bottom.equalToSuperview()
            
        }
        ///Exam
        examContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self.segmentControl.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.snp_bottomMargin)
        }
        easy.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(45)
            make.left.equalToSuperview().offset(23)
            make.right.equalTo(-23)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        image.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(self.image.snp.height)
        }
        
        normal.snp.makeConstraints { (make) in
            make.top.equalTo(self.easy.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(23)
            make.right.equalTo(-23)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        image2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(self.image.snp.height)
        }

        hard.snp.makeConstraints { (make) in
            make.top.equalTo(self.normal.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(23)
            make.right.equalTo(-23)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        image3.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(self.image.snp.height)
        }
    }
}

extension HomeController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopicsTableViewCell.identifier, for: indexPath) as! TopicsTableViewCell
        //cell.topicTextLabel.text = topics[indexPath.row].topic_name
            cell.configureLearningCell(topic: topics[indexPath.row])
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let topicID = topics[indexPath.row].topic_id
        ModelManager.getInstance().resetLearningWithTopicID(topicId: topicID)
        navigationController?.pushViewController(LearningViewController(topicID: topicID), animated: true)
        
    }
}

extension HomeController{
    
    
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
