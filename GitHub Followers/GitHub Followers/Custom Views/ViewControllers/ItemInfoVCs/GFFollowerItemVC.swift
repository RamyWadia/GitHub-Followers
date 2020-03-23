//
//  GFFollowerItemVC.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-03-18.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

protocol FollowerItemVCDelegate: class {
    func didTapGetFollowers(for user: User)
}


class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate: FollowerItemVCDelegate!
    
    init(user: User, delegate: FollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()    
    }
    
    private func configureItems() {
        itemIfnfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(background: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
    
}
