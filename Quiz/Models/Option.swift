//
//  QuizListCollectionViewFlowLayout.swift
//  Quiz
//
//  Created by rainedAllNight on 2017/11/19.
//  Copyright © 2017年 luowei. All rights reserved.
//

import UIKit
struct Option {
    var imageUrlStr: String
    
    init(imageUrlStr: String) {
        self.imageUrlStr = imageUrlStr
    }
}

extension Option: Equatable {
    public static func ==(left: Option, right: Option) -> Bool {
        return left.imageUrlStr == right.imageUrlStr
    }
}
