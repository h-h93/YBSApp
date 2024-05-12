//
//  YBSProfileIconImageView.swift
//  YBSApp
//
//  Created by hanif hussain on 11/05/2024.
//

import UIKit

class YBSProfileIconImageView: UIImageView {
    
    private let placeHolderImage = Images.defaultImage
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.systemMint.cgColor
        layer.cornerRadius = self.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
        clipsToBounds = true
        image = placeHolderImage
        contentMode = .scaleToFill
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(url: String) {
        Task(priority: .background) { image = await NetworkManager.shared.downloadImage(from: url) ?? placeHolderImage }
    }
}
