//
//  ViewController.swift
//  YBSApp
//
//  Created by hanif hussain on 08/05/2024.
//

import UIKit

class ViewController: YBSLoadingAnimationVC {
    enum Section {
        case main
    }
    var collectionView: YBSCollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, FlickrPhoto>!
    var photos = [FlickrPhoto]()
    var filteredPhotos = [FlickrPhoto]()
    var isSearching = false
    var hasMorePhotos = true
    var isLoadingMorePhotos = false
    var offset = 1
    let offsetIncrementValue = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getImages(page: offset)
    }
    
    
    func configure() {
        view.backgroundColor = .systemBackground
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }

    
    func configureCollectionView() {
        collectionView = YBSCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(YBSCollectionViewCell.self, forCellWithReuseIdentifier: YBSCollectionViewCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
                    let flickrPhotos = try await NetworkManager.shared.getImages(of: "Yorkshire", page: page)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YBSCollectionViewCell.reuseID, for: indexPath) as! YBSCollectionViewCell
            cell.set(picture: photo)
            return cell
        })
    }
    
    
    func updateUI(with picture: [FlickrPhoto]) {
        self.photos.append(contentsOf: picture)
        updateData(on: self.photos)
    }
    
    
    func updateData(on pictures: [FlickrPhoto]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FlickrPhoto>()
        snapshot.appendSections([.main])
        snapshot.appendItems(pictures)
        DispatchQueue.main.async { [weak self] in self?.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}


extension ViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = view.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMorePhotos, !isLoadingMorePhotos else { return }
            offset += offsetIncrementValue
            getImages(page: offset)
        }
    }
}


extension ViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredPhotos.removeAll()
            isSearching = false
            updateData(on: photos)
            return
        }
        
        isSearching = true
        filteredPhotos = photos.filter {
            $0.title.lowercased().contains(filter.lowercased())
            
        }
        updateData(on: filteredPhotos)
    }
}

/*
 var photoUserDetails = [UserProfile]()
 var photoDetails = [FlickrPhotoDetails]()
 
 for (index,item) in photos.enumerated() {
 let user = try await NetworkManager.shared.getUserDetails(userID: item.owner)
 let details = try await NetworkManager.shared.getPhotoDetails(photo: item)
 photoUserDetails.append(user)
 photoDetails.append(details)
 }
 */
