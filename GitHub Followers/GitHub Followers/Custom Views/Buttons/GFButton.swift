//
//  GFButton.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-02-23.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    
    private func configure() {
        setTitleColor(.white, for: .normal)
        layer.cornerRadius    = 10
        titleLabel?.font      = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func set(background: UIColor, title: String) {
        self.backgroundColor = background
        setTitle(title, for: .normal)
    }
    
}
