//
//  YBSImageView.swift
//  YBSApp
//
//  Created by hanif hussain on 10/05/2024.
//
import UIKit

class YBSImageView: UIImageView {
    private let placeHolderImage = Images.defaultImage
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage
        contentMode = .scaleToFill
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(url: String) {
        Task(priority: .background) { image = await NetworkManager.shared.downloadImage(from: url) ?? placeHolderImage }
    }
}
