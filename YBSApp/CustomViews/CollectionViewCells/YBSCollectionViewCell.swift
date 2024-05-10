//
//  YBSCollectionViewCell.swift
//  YBSApp
//
//  Created by hanif hussain on 10/05/2024.
//

import UIKit

class YBSCollectionViewCell: UICollectionViewCell {
    private let image = YBSImageView(frame: .zero)
    private let titeLabel = YBSTitleLabel(textAlignment: .center)
    
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
        layer.cornerRadius = 10
        titeLabel.minimumScaleFactor = 0.50
        let padding: CGFloat = 5
        
        addSubview(image)
        addSubview(titeLabel)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -55),
            
            titeLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: padding),
            titeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
    
    
    func set(picture: FlickrPhoto) {
        titeLabel.text = picture.title
        image.downloadPokemonImage(url: picture.imageURL)
    }
}
