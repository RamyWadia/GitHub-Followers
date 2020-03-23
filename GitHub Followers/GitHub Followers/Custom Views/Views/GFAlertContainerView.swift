//
//  GFAlertContainerView.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-03-22.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class GFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
