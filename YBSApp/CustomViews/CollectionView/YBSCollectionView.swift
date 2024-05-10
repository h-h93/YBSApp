//
//  YBSCollectionView.swift
//  YBSApp
//
//  Created by hanif hussain on 10/05/2024.
//

import UIKit

class YBSCollectionView: UICollectionView {
    static let reuseID = "Cell"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        let section = AppLayout.shared.configureImageCollectionViewSection()
        let layout = UICollectionViewCompositionalLayout(section: section)
        setCollectionViewLayout(layout, animated: true)
    }
}
