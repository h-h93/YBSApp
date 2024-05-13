//
//  ProfileInfoVC.swift
//  YBSApp
//
//  Created by hanif hussain on 12/05/2024.
//

import UIKit

class ProfileInfoVC: YBSLoadingAnimationVC {
    enum Section {
        case main
    }
    var userID: String!
    var collectionView: YBSCollectionView!
    var headerView = YBSProfileHeaderView()
    var dataSource: UICollectionViewDiffableDataSource<Section, FlickrPhoto>!
    var photos = [FlickrPhoto]()
    var hasMorePhotos = true
    var isLoadingMorePhotos = false
    var offset = 1
    let offsetIncrementValue = 1
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(userID: String) {
        self.init(nibName: nil, bundle: nil)
        self.userID = userID
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureCollectionView()
        configureDataSource()
        getImages(page: offset)
    }
    
    
    func configure() {
        view.backgroundColor = .systemBackground
    }
    
    // add this in 
    func configureHeaderView() {
        
    }
    
    
    func configureCollectionView() {
        collectionView = YBSCollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(YBSProfileCollectionViewCell.self, forCellWithReuseIdentifier: YBSProfileCollectionViewCell.reuseID)
        let layout = AppLayout.shared.createThreeGridCollectionLayout(in: collectionView)
        collectionView.setLayout(layout: layout)
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func getImages(page: Int) {
        defer {
            isLoadingMorePhotos = false
            dismissLoadingView()
        }
        isLoadingMorePhotos = true
        showLoadingView()
        Task {
            do {
                if hasMorePhotos {
                    let flickrPhotos = try await NetworkManager.shared.getUserPhotos(userID: userID, page: offset)
                    photos.append(contentsOf: flickrPhotos.0 ?? [FlickrPhoto]())
                    updateData(on: photos)
                    if !flickrPhotos.hasMorePages {
                        hasMorePhotos = false
                    }
                }
            } catch {
                if let error = error as? YBSError {
                    presentYBSAlert(title: "Oops", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, FlickrPhoto>(collectionView: collectionView, cellProvider: {
            collectionView, indexPath, photo in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YBSProfileCollectionViewCell.reuseID, for: indexPath) as! YBSProfileCollectionViewCell
            cell.set(picture: photo)
            return cell
        })
    }
    
    
    func updateData(on pictures: [FlickrPhoto]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FlickrPhoto>()
        snapshot.appendSections([.main])
        snapshot.appendItems(pictures)
        DispatchQueue.main.async { [weak self] in self?.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}


extension ProfileInfoVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let ContentHeight = scrollView.contentSize.height
        let height = view.frame.size.height
        
        if offsetY > ContentHeight - height {
            guard hasMorePhotos, !isLoadingMorePhotos else { return }
            offset += offsetIncrementValue
            getImages(page: offset)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = PhotoDetailsVC(photo: photos[indexPath.item])
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
