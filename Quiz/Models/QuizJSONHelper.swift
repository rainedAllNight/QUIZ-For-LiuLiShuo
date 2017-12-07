//
//  QuizListCollectionViewFlowLayout.swift
//  Quiz
//
//  Created by rainedAllNight on 2017/11/19.
//  Copyright © 2017年 luowei. All rights reserved.
//

import UIKit

class QuizJSONHelper {
    static func questionsFormLocal() -> [Question] {
        do {
            let path = Bundle.main.path(forResource: "zquestions", ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Array<String>]
            let questions = json.map({ (key, value) -> Question in
                let options = value.map({ (urlStr) -> Option in
                    return Option(imageUrlStr: urlStr)
                })
                return Question(prompt: key, options: options)
            })
            
            return questions
            
        } catch {
            assertionFailure("Couldn't load json with 'resource: zquestions, type: json', please check!!!")
            return [Question]()
        }
    }
}
