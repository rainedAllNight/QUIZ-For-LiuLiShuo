//
//  QuizListCollectionViewCell.swift
//  Quiz
//
//  Created by rainedAllNight on 2017/11/19.
//  Copyright © 2017年 luowei. All rights reserved.
//

import UIKit
import Kingfisher

class QuizListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet var optionsButtonArray: [OptionButton]!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        for button in optionsButtonArray {
            button.layer.cornerRadius = 6
            button.layer.masksToBounds = true
        }
    }
    
    func configureCell(_ question: Question, progress: String) {
        progressLabel.text = progress
        promptLabel.text = question.prompt
        let choice = question.choice
        
        for (index, button) in optionsButtonArray.enumerated() {
            guard let url = URL(string: question.options[index].imageUrlStr) else {
                continue
            }
            
            button.kf.setImage(with: url, for: .normal)
            button.optionIndex = index
            
            if let choice = choice, choice == question.options[index] {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
}
