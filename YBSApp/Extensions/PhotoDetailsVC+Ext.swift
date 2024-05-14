//
//  PhotoDetailsVC+Ext.swift
//  YBSApp
//
//  Created by hanif hussain on 13/05/2024.
//

import UIKit

extension PhotoDetailsVC: YBSProfileHeaderViewInteraction, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewRowCount
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YBSTableView.reuseID, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.minimumScaleFactor = 0.60
        switch indexPath.row {
        case  0:
            cell.textLabel?.text = "Title: \n\(photoDetails?.photo.title.content ?? "")"
        case 1:
            cell.textLabel?.text = "Description: \n\(photoDetails?.photo.description.content ?? "...")"
        case 2:
            cell.textLabel?.text = "Upload Date: \n\(date)"
        case 3:
            var tags = "Tags:\n"
            if !photoDetails.photo.tags.tag.isEmpty {
                for i in photoDetails.photo.tags.tag {
                    tags += "\(i.content), "
                }
            }
            cell.textLabel?.text = tags
        default:
            break
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewCellHeight
    }
    
    
    func didTapHeaderViews() {
        defer {
            dismissLoadingView()
        }
        showLoadingView()
        let profileInfoVC = ProfileInfoVC(userID: photo.owner)
        self.navigationController?.pushViewController(profileInfoVC, animated: true)
    }
}
