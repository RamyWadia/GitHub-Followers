//
//  FollowerCellCollectionViewCell.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-02-25.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "followerCell"
    let avatarImageView = AvatarImageView(frame: .zero)
    let usernameLable = GFTitleLable(textAlignment: .center, fontSise: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower: Follower) {
        usernameLable.text = follower.login
        avatarImageView.downloadImage(fromURL: follower.avatarUrl)
    }
    
    
    private func configure() {
        let padding: CGFloat = 8
        addSubviews(avatarImageView, usernameLable)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLable.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
