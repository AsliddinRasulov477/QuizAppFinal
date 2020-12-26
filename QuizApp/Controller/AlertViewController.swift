//
//  AlertViewController.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 9/26/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit
import SnapKit

class AlertViewController: UIViewController{
    
 //MARK:-Properties
    private let titleLabel :UILabel = {
          let label = UILabel()
        label.text = "21".localized
          label.adjustsFontSizeToFitWidth = true
          label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
          return label
      }()
    
    private let alertView:UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    
    private let circularProgressview:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
        view.autoresizingMask = [.flexibleWidth,
                                 .flexibleHeight,
                                 .flexibleTopMargin,
                                 .flexibleBottomMargin]
        return view
    }()
    
    private let scoreLabel:UILabel = {
        let label = UILabel()
        label.text = "740"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let numberofRightAnswersLbl :UILabel = {
        let label = UILabel()
        label.text = "22".localized
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16,weight: .semibold)
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let numberofWrongAnswersLbl :UILabel = {
        let label = UILabel()
        label.text = "23".localized
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.minimumScaleFactor = 0.6
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let showQuizAnswersButton:ShadowButton = {
        let button = ShadowButton()
        button.setTitle("25".localized, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8
        button.backgroundColor = .red
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapShowQuizAnswersButton), for: .touchUpInside)
        return button
    }()
    
    private let backToHomeButton:ShadowButton = {
        let button = ShadowButton()
        button.setTitle("26".localized, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .green
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapbackToHomeButton), for: .touchUpInside)
        return button
    }()
    
    private let shareLabel :UILabel = {
        let label = UILabel()
        label.text = "27".localized
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let facebookImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Facebook")
        return imageView
    }()
    
    private let instagramImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Instagram")
        return imageView
    }()
    
    private let twitterImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Twitter")
        return imageView
    }()
    
    private let quizList:[QuestionModel]
    private var fireworksController = FountainFireworkController()
    private let fireworks = ClassicFireworkController()
//MARK:-LIfe Cycle

    init(questions:[QuestionModel]){
        self.quizList = questions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    
        setupView()
        configureWithData(with: quizList)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.fireworksController.addFirework(sparks: 100, above: alertView)
        //  self.fireworks.addFireworks(count: 40, sparks: 8, around:alertView)
    }
 
//MARK: - UI Setup
    func setupView(){
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.85)
        view.addSubview(alertView)
        alertView.backgroundColor =  #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
        alertView.addSubview(titleLabel)
        alertView.addSubview(circularProgressview)
        circularProgressview.addSubview(scoreLabel)
        alertView.addSubview(numberofRightAnswersLbl)
        alertView.addSubview(numberofWrongAnswersLbl)
        alertView.addSubview(showQuizAnswersButton)
        alertView.addSubview(backToHomeButton)
        alertView.addSubview(shareLabel)
        alertView.addSubview(facebookImageView)
        alertView.addSubview(twitterImageView)
        alertView.addSubview(instagramImageView)
    }
    
    var strokeEnd: CGFloat = 0.0
    func  configureWithData(with questions:[QuestionModel]){
        var numberOfRightAnswers = 0
        var numberOfWrongAnswers = 0
        for question in questions {
            if question.rightAnswerInex == question.userAnswerIndex{
                numberOfRightAnswers += 1
            }
            else{
                numberOfWrongAnswers += 1
            }
        }
        numberofRightAnswersLbl.text =  "\("22".localized): \(numberOfRightAnswers)"
        numberofWrongAnswersLbl.text =  "\("23".localized): \(numberOfWrongAnswers)"
        scoreLabel.text = "\( Int( (Double(numberOfRightAnswers)/Double(quizList.count))*100))%"
        strokeEnd  = CGFloat( numberOfRightAnswers)/CGFloat(questions.count)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        alertView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view.snp.centerY)
            make.leading.equalTo(self.view.snp.leading).offset(22)
            make.trailing.equalTo(self.view.snp.trailing).offset(-22)
            make.height.equalTo(self.view.snp.width).multipliedBy(1.5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.alertView.snp.top).offset(28)
            make.leading.equalTo(self.alertView.snp.leading).offset(46)
            make.trailing.equalTo(self.alertView.snp.trailing).offset(-46)
        }
        
        circularProgressview.snp.makeConstraints { (make) in
            make.top.equalTo(self.alertView.snp.top).offset(68)
            make.centerX.equalTo(self.alertView.snp.centerX)
            make.width.equalTo(self.alertView.snp.width).multipliedBy(0.5)
            make.height.equalTo(self.alertView.snp.width).multipliedBy(0.5)
        }
        
        scoreLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.alertView.snp.centerX)
            make.centerY.equalTo(self.circularProgressview.snp.centerY)
        }
        
        numberofRightAnswersLbl.snp.makeConstraints { (make) in
            make.top.equalTo(self.circularProgressview.snp.bottom).offset(20)
            make.centerX.equalTo(self.alertView.snp.centerX)
            make.left.equalTo(self.alertView.snp.left).offset(20)
            make.right.equalTo(self.alertView.snp.right).offset(-20)
            make.height.equalTo(21)
        }
        numberofWrongAnswersLbl.snp.makeConstraints { (make) in
            make.top.equalTo(self.numberofRightAnswersLbl.snp.bottom).offset(2)
            make.centerX.equalTo(self.alertView.snp.centerX)
            make.left.equalTo(self.alertView.snp.left).offset(20)
            make.right.equalTo(self.alertView.snp.right).offset(-20)
            make.height.equalTo(21)
        }
        showQuizAnswersButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.numberofWrongAnswersLbl.snp.bottom).offset(20)
            make.centerX.equalTo(self.alertView.snp.centerX)
            make.width.equalTo(self.alertView.snp.width).multipliedBy(0.7)
            make.height.equalTo(50)
        }
        backToHomeButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.showQuizAnswersButton.snp.bottom).offset(10)
            make.centerX.equalTo(self.alertView.snp.centerX)
            make.width.equalTo(self.alertView.snp.width).multipliedBy(0.7)
            make.height.equalTo(50)
        }
        shareLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.backToHomeButton.snp.bottom).offset(10)
            make.centerX.equalTo(self.alertView.snp.centerX)
            make.height.equalTo(41)
        }
        twitterImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.shareLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self.alertView.snp.centerX)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        facebookImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.shareLabel.snp.bottom).offset(10)
            make.trailing.equalTo(self.twitterImageView.snp.leading).offset(-10)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        instagramImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.shareLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.twitterImageView.snp.trailing).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        drawTheCircularProgressBar()
    }
    
//MARK:-Actions
    
    @objc func didTapShowQuizAnswersButton(){
        navigationController?.pushViewController(ResultsViewController(questions: quizList), animated: true)
    }
    
    @objc func didTapbackToHomeButton(){
        self.navigationController?.popToRootViewController(animated: true)
    }
}

class CircleView: UIView {
    override class var layerClass: AnyClass { return CAShapeLayer.self }
    
    var shapeLayer: CAShapeLayer { return layer as! CAShapeLayer }
    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        
    }
}

extension AlertViewController {
    func drawTheCircularProgressBar() {
        let size = self.alertView.frame.width/2
        let grayTrack = CircleView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        grayTrack.center = CGPoint(x: circularProgressview.bounds.midX, y: circularProgressview.bounds.midY)
        grayTrack.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        grayTrack.shapeLayer.strokeColor = UIColor.lightGray.cgColor
        grayTrack.shapeLayer.fillColor = UIColor.clear.cgColor
        grayTrack.shapeLayer.lineWidth = 16
        grayTrack.shapeLayer.cornerRadius = 8
        grayTrack.shapeLayer.strokeEnd = 1
        circularProgressview.addSubview(grayTrack)
        
        let progressTrack = CircleView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        progressTrack.center = CGPoint(x: circularProgressview.bounds.midX, y: circularProgressview.bounds.midY)
        progressTrack.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        progressTrack.shapeLayer.strokeColor = UIColor.green.cgColor
        progressTrack.shapeLayer.fillColor = UIColor.clear.cgColor
        progressTrack.shapeLayer.lineWidth = 16
        progressTrack.shapeLayer.lineCap = .round
        progressTrack.shapeLayer.strokeEnd = strokeEnd
        circularProgressview.addSubview(progressTrack)
    }
}

