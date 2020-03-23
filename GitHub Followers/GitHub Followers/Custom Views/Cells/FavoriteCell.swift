//
//  FavoriteCell.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-03-22.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

   static let reuseID = "favoriteCell"
   let avatarImageView = AvatarImageView(frame: .zero)
   let usernameLable = GFTitleLable(textAlignment: .left, fontSise: 26)

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favorite: Follower) {
        usernameLable.text = favorite.login
        avatarImageView.downloadImage(fromURL: favorite.avatarUrl)
    }
    
    
    private func configure() {
        addSubviews(avatarImageView, usernameLable)
        accessoryType        = .disclosureIndicator
        let padding: CGFloat = 12
        
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLable.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLable.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
