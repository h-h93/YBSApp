//
//  Date+Ext.swift
//  YBSApp
//
//  Created by hanif hussain on 13/05/2024.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
}
