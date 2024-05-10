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

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureCollectionView()
        configureDataSource()
        getImages()
    }
    
    
    func configure() {
        view.backgroundColor = .systemPink
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
    
    
    func getImages() {
        defer {
            dismissLoadingView()
        }
        Task {
            showLoadingView()
            do {
                photos = try await NetworkManager.shared.getImages(of: "Yorkshire", page: 1) ?? [FlickrPhoto]()
                updateData(on: photos)
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
    
}
