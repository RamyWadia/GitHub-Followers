//
//  FollowersListVC.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-02-23.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit


class FollowersListVC: GFDataLoadingVC {
    
    enum Section { case main }
    
    var userName: String!
    var followers:         [Follower] = []
    var filteredFollowers: [Follower] = []
    var page                   = 1
    var hasMoreFollowers       = true
    var isSearching            = false
    var isLoadingMoreFollowers = false
    
    var collectioView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.userName = username
        title         = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureFollowerListVC()
        configureCollectionView()
        configureDataSource()
        configureSearchController()
        getFollower(username: userName, page: page)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureSearchController() {
        let searchController                      = UISearchController()
        searchController.searchResultsUpdater     = self
        searchController.searchBar.placeholder    = "Search for a user"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController           = searchController
    }
    
    
    func getFollower(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollower(for: username, page: page) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue , buttonTitle: "OK")
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    
    func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        if followers.isEmpty {
            let message = "This user has no followers, Go and follow them 😀"
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
                return
            }
        }
        self.updateData(on: self.followers)
    }
    
    
    func configureFollowerListVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = false
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func configureCollectionView() {
        collectioView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.creatThreeColumnLayout(in: view))
        view.addSubview(collectioView)
        collectioView.delegate = self
        collectioView.backgroundColor = .systemBackground
        collectioView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }

    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectioView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(on followers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapShot, animatingDifferences: true) }
    }
    
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getUser(for: userName) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                self.addUserToFavorit(user: user)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue , buttonTitle: "OK")
            }
        }
    }
    
    
    func addUserToFavorit(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PresistanceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favoraited this user 🎉", buttonTitle: "Done")
                return
            }
            self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
        }
    }
    
}

//MARK: - UICollectionViewDelegation

extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY        = scrollView.contentOffset.y
        let contentHight   = scrollView.contentSize.height
        let hitght         = scrollView.frame.size.height
        
        if offsetY > contentHight - hitght {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollower(username: userName, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray         = isSearching ? filteredFollowers : followers
        let follower            = activeArray[indexPath.item]
        
        let destinationVC       = UserInfoVC()
        destinationVC.userName  = follower.login
        destinationVC.delegate  = self
        let navController       = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
        
    }
    
}

//MARK: - UISearchResultDelegation

extension FollowersListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
            
        }
        isSearching = true
        filteredFollowers = followers.filter{ $0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
    }
}

//MARK: - FollowersListRequestDelegation

extension FollowersListVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        self.userName = username
        title         = username
        page          = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectioView.setContentOffset(.zero, animated: true)
        collectioView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollower(username: username, page: page)
    }
}


