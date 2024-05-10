//
//  Photos.swift
//  YBSApp
//
//  Created by hanif hussain on 08/05/2024.
//

import Foundation

struct Photos: Codable, Hashable {
    let page, pages, perpage, total: Int
    var photo: [FlickrPhoto]
}
