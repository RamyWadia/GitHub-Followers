//
//  Date+Ext.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-03-18.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import Foundation

extension Date {

func convertToMonthYearFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM yyyy"
    return dateFormatter.string(from: self)
    }
}
