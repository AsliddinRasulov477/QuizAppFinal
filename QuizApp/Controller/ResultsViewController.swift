//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Akhadjon Abdukhalilov on 9/27/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

//MARK:-Properties
    
    private func collectionViewLayout()->UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:10, left: 22, bottom: 0, right: 22)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 21
        layout.minimumInteritemSpacing = 21
        layout.itemSize = CGSize(width: (view.frame.width-88)/3, height: (view.frame.width-88)/3)
        return layout
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(ResultsCollectionViewCell.self, forCellWithReuseIdentifier: ResultsCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor =  #colorLiteral(red: 0.9803171754, green: 0.9804343581, blue: 0.9802773595, alpha: 1)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    private let quizList:[QuestionModel]

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
         setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

//MARK:UISetup
    private func setupViews(){
        
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        view.backgroundColor =  #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
        view.addSubview(collectionView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
            make.trailing.equalTo(self.view.snp.trailing)
            make.leading.equalTo(self.view.snp.leading)
       }
    }
//MARK:-Action
    @objc private func didTapDone(){
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension ResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultsCollectionViewCell.identifier, for: indexPath) as! ResultsCollectionViewCell
        let question = quizList[indexPath.row]
        cell.congiureCell(with: question)
        cell.questionNumberLabel.text = "\(indexPath.row + 1)-\("question".localized)"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ResultDetailViewController(question: quizList[indexPath.row]), animated: true)
    }
   
}
