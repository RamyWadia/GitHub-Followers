//
//  GFButton.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-02-23.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class GFTextField: UITextField {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
            configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius          = 10
        layer.borderColor           = UIColor.systemGray4.cgColor
        layer.borderWidth           = 2
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        keyboardType                = .default
        returnKeyType               = .go
        clearButtonMode             = .whileEditing
        placeholder                 = "Enter user name"
    }
}
