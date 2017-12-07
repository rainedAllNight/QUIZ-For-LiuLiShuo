//
//  QuizListCollectionViewFlowLayout.swift
//  Quiz
//
//  Created by rainedAllNight on 2017/11/19.
//  Copyright © 2017年 luowei. All rights reserved.
//

import UIKit
public typealias ActionHandle = (UIAlertAction) -> Swift.Void

extension UIViewController {
   public func showAlertController(_ title: String?, message: String?, defaultHandleTitle: String, defaultHandle: ActionHandle? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: defaultHandleTitle, style: .default, handler: { (action) in
            defaultHandle?(action)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func delay(_ delay:Double? = 0.5, closure:@escaping ()->Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay! * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure
        )
    }
}
