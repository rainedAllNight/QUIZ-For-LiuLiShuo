//
//  QuizListCollectionViewFlowLayout.swift
//  Quiz
//
//  Created by rainedAllNight on 2017/11/19.
//  Copyright © 2017年 luowei. All rights reserved.
//

import UIKit

class QuizListCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        guard let collectionView = self.collectionView
            else {
            return
        }
        
        let horizontalMargin: CGFloat = 30
        let verticalMargin: CGFloat = 30
        let itemWidth = collectionView.bounds.width - horizontalMargin * 2
        let itemHeight = collectionView.bounds.height - verticalMargin * 2
        
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(row: item, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let x = collectionView.bounds.width * CGFloat(item) + verticalMargin
            
            attribute.frame = CGRect(x: x,
                                     y: horizontalMargin,
                                     width: itemWidth,
                                     height: itemHeight)
            
            self.layoutAttributes.append(attribute)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = self.collectionView else {
            return super.layoutAttributesForElements(in: rect)
        }
        
        for attribute in layoutAttributes {
            if attribute.frame.intersects(rect) {
                let maxCenterMargin: CGFloat = collectionView.bounds.size.width
                let itemOffset: CGFloat = attribute.center.x - collectionView.contentOffset.x
                let position = itemOffset / maxCenterMargin - 0.5
                let scale = 1.0 - 0.3 * abs(position)
                
                attribute.alpha = 1.0 - abs(position)
                attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = self.collectionView else {
            return CGSize.zero
        }
        
        let width = CGFloat(collectionView.numberOfItems(inSection: 0)) * collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        return CGSize(width: width, height: height)
    }
}
