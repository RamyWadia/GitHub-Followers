//
//  GFItemIfnfoVC.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-03-16.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

protocol ItemInfoVCDelegate: class {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}


class GFItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let itemIfnfoViewOne = GFItemInfoView()
    let itemInfoViewTwo  = GFItemInfoView()
    let actionButton     = GFButton()
    
    var user: User!
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureBackgroundView()
        configureLayoutUI()
        configureStackView()
        configureActionButton()
      
    }
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func actionButtonTapped() {}
    
    private func configureLayoutUI() {
        view.addSubviews(stackView, actionButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    private func configureStackView() {
        stackView.axis         = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemIfnfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
}
