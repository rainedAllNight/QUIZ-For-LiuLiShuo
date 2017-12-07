//
//  QuizListViewController.swift
//  Quiz
//
//  Created by rainedAllNight on 2017/11/19.
//  Copyright © 2017年 luowei. All rights reserved.
//

import UIKit

class QuizListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            submitButton.layer.cornerRadius = 10
            submitButton.layer.masksToBounds = true
            submitButton.setBackgroundImage(UIImage.imageWithColor(UIColor.lightText), for: .disabled)
            submitButton.setBackgroundImage(UIImage.imageWithColor(UIColor.color(withHex: "2EB187")), for: .normal)
        }
    }
    @IBOutlet weak var countdownLabel: UILabel!
    
    let cellIdentifier = "QuizListCollectionViewCell"
    weak var timer: Timer?
    var remainingTime: Int = 120 {
        didSet {
            countdownLabel.text = formatRemainingTimeString(seconds: remainingTime)
            countdownLabel.textColor = remainingTime <= 10 ? UIColor.color(withHex: "D93829") : UIColor.black
        }
    }
    var questions: [Question] = QuizJSONHelper.questionsFormLocal()
        
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleQuestions()
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showQuizStartAlert()
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Private method
    
    private func shuffleQuestions() {
        var shuffledQuestions = questions.shuffle()
        shuffledQuestions = shuffledQuestions.map({ (question) -> Question in
            var newQuestion = question
            newQuestion.options = question.options.shuffle()
            return newQuestion
        })
        
        questions = shuffledQuestions
    }
    
    private func showQuizStartAlert() {
        showAlertController("你有两分钟的时间来完成下面这些测试", message: nil, defaultHandleTitle: "开始") { (action) in
            self.startTimer()
        }
    }

    private func startTimer() {
        weak var weakSelf = self
        if timer == nil {
            timer = Timer.scheduleCommonModeTimer(repeatInterval: 1, handler: { (timer) in
                weakSelf?.updateTimer()
            })
        }
        
        timer?.fireDate = .distantPast
    }
    
    @objc private func updateTimer() {
        if remainingTime < 1 {
            self.timer?.fireDate = .distantFuture
            self.showQuizEndAlert("时间到了")
        } else {
            remainingTime -= 1
        }
    }
    
    private func formatRemainingTimeString(seconds: Int) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    private func showQuizEndAlert(_ message: String) {
        self.timer?.fireDate = .distantFuture
        showAlertController(message, message: "您共答对\(questions.count)中的\(getCorrectQuestionsCount())道题", defaultHandleTitle: "再试一次", defaultHandle: { (action) in
            self.remainingTime = 120
            self.startTimer()
            self.questions = QuizJSONHelper.questionsFormLocal()
            self.shuffleQuestions()
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: false)
            self.collectionView.reloadData()
            self.submitButton.isEnabled = self.hasFinishedCurrentQuiz()
        })
    }
    
    private func getCorrectQuestionsCount() -> Int {
        let correctQuestions = questions.filter({ (question) -> Bool in
            if let choice = question.choice, choice == question.answer {
                return true
            } else {
                return false
            }
        })
        
        return correctQuestions.count
    }
    
    private func hasFinishedCurrentQuiz() -> Bool {
        let finishedQuestions = questions.filter { (question) -> Bool in
            return question.choice != nil
        }
        
        return finishedQuestions.count == questions.count
    }
    
    // MARK: - IBAction
    
    @IBAction func handleSubmitButtonAction(_ sender: UIButton) {
        self.showQuizEndAlert("恭喜🎉")
    }
    
    @IBAction func handleOptionButtonAction(_ sender: OptionButton) {
        guard let indexPath = collectionView.indexPathForItem(at: sender.convert(CGPoint.zero, to: collectionView)) else {
            return
        }
        
        let questionIndex = indexPath.item
        let optionIndex = sender.optionIndex
        let choice = self.questions[questionIndex].options[optionIndex]
        self.questions[questionIndex].choice = choice
        collectionView.reloadData()
        
        if questionIndex != questions.count - 1 {
            delay(closure: {
                self.collectionView.scrollToItem(at: IndexPath(item: questionIndex + 1, section: 0), at: .centeredHorizontally, animated: true)
            })
        }
        
        let hasFinishedCurrentQuiz = self.hasFinishedCurrentQuiz()
        submitButton.isEnabled = hasFinishedCurrentQuiz
        if hasFinishedCurrentQuiz {
            self.timer?.fireDate = .distantFuture
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: - CollectionViewDelegate & CollectionViewDataSource

extension QuizListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! QuizListCollectionViewCell
        let progress = "\(indexPath.row + 1)/\(questions.count)"
        cell.configureCell(questions[indexPath.row], progress: progress)
        return cell
    }
}
