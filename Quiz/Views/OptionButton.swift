//
//  OptionButton.swift
//  Quiz
//
//  Created by rainedAllNight on 2017/11/20.
//  Copyright © 2017年 luowei. All rights reserved.
//

import UIKit

class OptionButton: UIButton {
    
    var checkImageView: UIImageView = UIImageView(image: UIImage(named: "Check"))
    var optionIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    private func configureUI() {
        self.backgroundColor = UIColor.white
        checkImageView.isHidden = !self.isSelected
        checkImageView.contentMode = .scaleAspectFill
        self.addSubview(checkImageView)
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
       
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[checkImageView]-16-|", options: .alignAllCenterX, metrics: nil, views: ["checkImageView": checkImageView])
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[checkImageView]-16-|", options: .alignAllCenterX, metrics: nil, views: ["checkImageView": checkImageView])
        self.addConstraints(vConstraints)
        self.addConstraints(hConstraints)
    }
    
    override var isSelected: Bool {
        didSet {
            checkImageView.isHidden = !isSelected
        }
    }

}
