//
//  UIImageHelper.swift
//  Quiz
//
//  Created by rainedAllNight on 2017/11/20.
//  Copyright © 2017年 luowei. All rights reserved.
//

import UIKit

extension UIImage {
    public class func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
