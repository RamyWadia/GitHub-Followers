//
//  GFTitleLable.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-02-23.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class GFTitleLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSise: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSise, weight: .bold)
    }
    
    
    private func configure() {
        textColor                 = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
