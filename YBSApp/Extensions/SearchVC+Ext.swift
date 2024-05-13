//
//  SearchVC+Ext.swift
//  YBSApp
//
//  Created by hanif hussain on 13/05/2024.
//

import UIKit

extension SearchVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = view.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMorePhotos, !isLoadingMorePhotos else { return }
            offset += offsetIncrementValue
            getImages(of: searchTerm, page: offset)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = PhotoDetailsVC(photo: photos[indexPath.item])
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}


extension SearchVC: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let filter = searchBar.text, !filter.isEmpty else { return }
        searchTerm = filter
        photos.removeAll()
        offset = 1
        getImages(of: filter, page: offset)
    }
}
