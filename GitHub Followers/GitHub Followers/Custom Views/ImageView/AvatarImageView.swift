//
//  AvatarImageView.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-02-25.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {
    
    let placeholderImage = Images.avatarPlaceHolder
    let cache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius   = 10
        clipsToBounds        = true
        image                = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
    
}
