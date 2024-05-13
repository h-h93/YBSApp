//
//  FlickrPhoto.swift
//  YBSApp
//
//  Created by hanif hussain on 08/05/2024.
//

import Foundation

struct FlickrPhoto: Codable, Hashable {
    let uniqueID = UUID().uuidString
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    
    var imageURL: String {
        let urlString = String(format: FlickrURL.imageURL.rawValue, farm, server, id, secret)
        return urlString
    }
}
