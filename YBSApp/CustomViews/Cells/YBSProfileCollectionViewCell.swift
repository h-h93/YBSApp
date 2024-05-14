//
//  YBSProfileCollectionViewCell.swift
//  YBSApp
//
//  Created by hanif hussain on 13/05/2024.
//

import UIKit

class YBSProfileCollectionViewCell: UICollectionViewCell {
    private let image = YBSImageView(frame: .zero)
    
    static let reuseID = "Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.secondarySystemBackground.cgColor
        image.contentMode = .scaleAspectFill
        
        addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
    func set(picture: FlickrPhoto) {
        image.downloadImage(url: picture.imageURL)
    }
}
