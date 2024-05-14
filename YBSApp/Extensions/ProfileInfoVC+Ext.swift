//
//  ProfileInfoVC+Ext.swift
//  YBSApp
//
//  Created by hanif hussain on 14/05/2024.
//

import UIKit

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

