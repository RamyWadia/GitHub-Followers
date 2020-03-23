//
//  UITableView + Ext.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-03-23.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UITableView(frame: .zero)
    }
    
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
}
