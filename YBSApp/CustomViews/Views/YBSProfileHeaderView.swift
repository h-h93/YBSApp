//
//  YBSProfileHeaderView.swift
//  YBSApp
//
//  Created by hanif hussain on 12/05/2024.
//

import UIKit

protocol YBSProfileHeaderViewInteraction: AnyObject {
    func didTapHeaderViews()
}

class YBSProfileHeaderView: UIView {
    private let profileImage = YBSProfileIconImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    private let usernameLabel = YBSTitleLabel(textAlignment: .left)
    private let descriptionLabel = YBSBodyLabel(textAlignment: .left)
    private let locationLabel = UILabel()
    weak var headerDelegate: YBSProfileHeaderViewInteraction!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        usernameLabel.adjustsFontSizeToFitWidth = true
        usernameLabel.numberOfLines = 0
        usernameLabel.minimumScaleFactor = 0.50
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont.systemFont(ofSize: 10)
        locationLabel.textColor = .secondaryLabel
        locationLabel.textAlignment = .center
        locationLabel.minimumScaleFactor = 0.30
        
        descriptionLabel.textColor = .tertiaryLabel
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.65
        descriptionLabel.numberOfLines = 0
        
        addSubviews(profileImage, usernameLabel, locationLabel, descriptionLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loadUserProfile))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(loadUserProfile))
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(loadUserProfile))
        profileImage.addGestureRecognizer(tapGesture)
        usernameLabel.addGestureRecognizer(tapGesture2)
        descriptionLabel.addGestureRecognizer(tapGesture3)
        
        NSLayoutConstraint.activate([
            profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50),
            profileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -60),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            
            usernameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 5),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            locationLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            locationLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5),
            locationLabel.heightAnchor.constraint(equalToConstant: 15),
            locationLabel.widthAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
    func set(user: UserProfile) {
        let username = user.person.username.values.first ?? "Unknown user"
        let location = user.person.location?.values.first ?? "Unknown"
        var description = "Nothing to read here..."
        if user.person.description?.values.first != "" {
            description = (user.person.description?.values.first)!
        }
        
        let farmName = "\(user.person.iconfarm ?? 0)"
        let iconServer = user.person.iconserver
        let nsid = user.person.nsid
        let formatString = FlickrURL.profileImageURL.rawValue
        let urlString = String(format: formatString, farmName, iconServer ?? "0", nsid)
        
        profileImage.downloadImage(url: urlString)
        usernameLabel.text = username
        locationLabel.text = location
        descriptionLabel.text = description
    }
    
    
    func disableUserInteraction() {
        profileImage.isUserInteractionEnabled = false
        usernameLabel.isUserInteractionEnabled = false
        descriptionLabel.isUserInteractionEnabled = false
    }
    
    
    @objc func loadUserProfile(_ gesture: UITapGestureRecognizer) {
        headerDelegate.didTapHeaderViews()
    }
}
