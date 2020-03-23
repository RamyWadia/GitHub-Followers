//
//  User.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-02-24.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import Foundation


struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}
