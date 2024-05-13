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
    
    
    func pinToEdges(of superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.topAnchor),
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
    
    
    func pinToSafeAreaEdges(of superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
