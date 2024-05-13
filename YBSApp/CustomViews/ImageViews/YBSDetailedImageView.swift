//
//  YBSDetailedImageView.swift
//  YBSApp
//
//  Created by hanif hussain on 12/05/2024.
//

import UIKit

class YBSDetailedImageView: UIImageView {
    
    private let placeHolderImage = Images.defaultImage
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        clipsToBounds = true
        image = placeHolderImage
        contentMode = .scaleToFill
        translatesAutoresizingMaskIntoConstraints = false
    }
}
