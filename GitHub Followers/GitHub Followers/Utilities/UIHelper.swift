//
//  UIHelper.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-02-27.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

enum UIHelper {
    
    static func creatThreeColumnLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayour                  = UICollectionViewFlowLayout()
        flowLayour.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayour.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayour
    }
}
