//
//  UIView+Ext.swift
//  YBSApp
//
//  Created by hanif hussain on 10/05/2024.
//

import UIKit

extension UIView {
    func addSubviews(_ view: UIView...) {
        for view in view { addSubview(view) }
    }
}
