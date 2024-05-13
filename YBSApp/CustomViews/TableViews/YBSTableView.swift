//
//  YBSTableView.swift
//  YBSApp
//
//  Created by hanif hussain on 12/05/2024.
//

import UIKit

class YBSTableView: UITableView {
    static let reuseID = "Cell"
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        self.allowsSelection = false
        self.bouncesVertically = true
        
    }
}
