//
//  PhotoDetailsVC.swift
//  YBSApp
//
//  Created by hanif hussain on 12/05/2024.
//

import UIKit

class PhotoDetailsVC: YBSLoadingAnimationVC {
    let scrollView = UIScrollView()
    let headerView = YBSProfileHeaderView(frame: .zero)
    let contentView = UIView()
    let tableView = YBSTableView()
    let imageView = YBSDetailedImageView(frame: .zero)
    var photo: FlickrPhoto!
    var photoDetails: FlickrPhotoDetails!
    var user: UserProfile!
    var date = ""
    var tableViewRowCount = 4
    var tableViewCellHeight: CGFloat = 100
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(photo: FlickrPhoto) {
        self.init(nibName: nil, bundle: nil)
        self.photo = photo
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureHeader()
        configureScrollView()
        configureContentView()
        configureImageView()
        configureTableView()
        getImageData()
    }
    

    func configure() {
        view.backgroundColor = .systemBackground
    }
    
    
    func configureHeader() {
        view.addSubview(headerView)
        headerView.headerDelegate = self
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    func configureScrollView() {
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func configureContentView() {
        contentView.backgroundColor = .systemBackground
        scrollView.addSubview(contentView)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 650)
        ])
    }
    
    
    func configureImageView() {
        contentView.addSubview(imageView)
        Task {
            let image = await NetworkManager.shared.downloadImage(from: photo.imageURL)
            imageView.image = image
        }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),
        ])
    }
    
    
    func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: YBSTableView.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        contentView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    
    func getImageData() {
        defer {
            dismissLoadingView()
        }
        showLoadingView()
        Task() {
            do {
                user = try await NetworkManager.shared.getUserDetails(userID: photo.owner)
                photoDetails = try await  NetworkManager.shared.getPhotoDetails(photo: photo)
                let timeSince = Double(photoDetails?.photo.dateuploaded ?? "0")
                let imageDate = Date(timeIntervalSince1970: timeSince ?? 0)
                date = imageDate.convertToMonthYearFormat()
                headerView.set(user: user)
                tableView.reloadDataOnMainThread()
            } catch {
                presentYBSAlert(title: "Something went wrong", message: "Unable to download picture information", buttonTitle: "Ok")
            }
        }
    }
}
