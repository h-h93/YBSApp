//
//  YBSCollectionViewCell.swift
//  YBSApp
//
//  Created by hanif hussain on 10/05/2024.
//

import UIKit

class YBSCollectionViewCell: UICollectionViewCell {
    private let image = YBSImageView(frame: .zero)
    private let profileImage = YBSProfileIconImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    private let titeLabel = YBSBodyLabel(textAlignment: .left)
    private let tagLabel = UILabel()
    
    static let reuseID = "Cell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureTagLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.secondarySystemBackground.cgColor
        layer.cornerRadius = 10
        let padding: CGFloat = 5
        
        titeLabel.adjustsFontSizeToFitWidth = true
        
        addSubview(image)
        addSubview(profileImage)
        addSubview(titeLabel)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            image.heightAnchor.constraint(equalToConstant: 200),
            
            profileImage.topAnchor.constraint(equalTo: image.bottomAnchor, constant: padding),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            
            titeLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: padding),
            titeLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: padding),
            titeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titeLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    private func configureTagLabel() {
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.font = UIFont.systemFont(ofSize: 10)
        tagLabel.lineBreakMode = .byTruncatingTail
        tagLabel.numberOfLines = 2
        tagLabel.textColor = .label.withAlphaComponent(0.7)
        addSubview(tagLabel)
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            tagLabel.topAnchor.constraint(equalTo: titeLabel.bottomAnchor, constant: padding),
            tagLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            tagLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            tagLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
    func set(picture: FlickrPhoto) {
        Task {
            let user = try await NetworkManager.shared.getUserDetails(userID: picture.owner)
            let details = try await NetworkManager.shared.getPhotoDetails(photo: picture)
            
            titeLabel.text = user.person.username.values.first
            
            var tags = "Tags:"
            for i in details.photo.tags.tag {
                tags += " \(i.content),"
            }
            tagLabel.text = tags
            
            let farmName = "\(user.person.iconfarm ?? 0)"
            let iconServer = user.person.iconserver
            let nsid = user.person.nsid
            
            let formatString = FlickrURL.profileImageURL.rawValue
            let urlString = String(format: formatString, farmName, iconServer ?? "0", nsid)
            
            profileImage.downloadImage(url: urlString)
        }
        image.downloadImage(url: picture.imageURL)
    }
}
