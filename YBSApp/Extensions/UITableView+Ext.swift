//
//  UITableView+Ext.swift
//  YBSApp
//
//  Created by hanif hussain on 13/05/2024.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
}
