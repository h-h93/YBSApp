//
//  ViewController.swift
//  YBSApp
//
//  Created by hanif hussain on 08/05/2024.
//

import UIKit

class SearchVC: YBSLoadingAnimationVC {
    enum Section {
        case main
    }
    var searchTerm = "Yorkshire"
    var collectionView: YBSCollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, FlickrPhoto>!
    var photos = [FlickrPhoto]()
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
        getImages(of: searchTerm, page: offset)
    }
    
    
    func configure() {
        view.backgroundColor = .systemBackground
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }

    
    func configureCollectionView() {
        collectionView = YBSCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = AppLayout.shared.configureImageCollectionViewSection()
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.setLayout(layout: layout)
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
    
    
    func getImages(of searchTerm: String, page: Int) {
        defer {
            isLoadingMorePhotos = false
            dismissLoadingView()
        }
        isLoadingMorePhotos = true
        showLoadingView()
        Task {
            do {
                if hasMorePhotos {
                    let flickrPhotos = try await NetworkManager.shared.getImages(of: searchTerm, page: page)
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
    
    
    func updateData(on pictures: [FlickrPhoto]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FlickrPhoto>()
        snapshot.appendSections([.main])
        snapshot.appendItems(pictures)
        DispatchQueue.main.async { [weak self] in self?.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}
