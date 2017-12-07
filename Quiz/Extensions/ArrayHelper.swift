//
//  QuizListCollectionViewFlowLayout.swift
//  Quiz
//
//  Created by rainedAllNight on 2017/11/19.
//  Copyright © 2017年 luowei. All rights reserved.
//

import UIKit

extension Array {
    public func shuffle() -> Array {
        var list = self
        for index in 0..<list.count {
            let newIndex = Int(arc4random_uniform(UInt32(list.count-index))) + index
            if index != newIndex {
                list.swapAt(index, newIndex)
            }
        }
        return list
    }
}
