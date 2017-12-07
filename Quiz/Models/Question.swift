//
//  QuizListCollectionViewFlowLayout.swift
//  Quiz
//
//  Created by rainedAllNight on 2017/11/19.
//  Copyright © 2017年 luowei. All rights reserved.
//

import UIKit

struct Question {
    var prompt: String = ""
    var options: [Option]
    var choice: Option?
    var answer: Option
    
    init(prompt: String, options: [Option]) {
        self.prompt = prompt
        self.options = options
        self.answer = options.first!
    }
}

