//
//  FlickrPhotoDetails.swift
//  YBSApp
//
//  Created by hanif hussain on 11/05/2024.
//

import Foundation

// MARK: - FlickrPhotoDetails
struct FlickrPhotoDetails: Codable, Hashable {
    let photo: PhotoDetails
    let stat: String
}

// MARK: - Photo
struct PhotoDetails: Codable, Hashable {
    let id, secret, server: String
    let farm: Int
    let dateuploaded: String
    let isfavorite: Int
    let license, safetyLevel: String?
    let rotation: Int
    let title, description: Comments
    let dates: Dates
    let views: String
    let comments: Comments
    let notes: Notes
    let tags: Tags
    let media: String

}

// MARK: - Comments
struct Comments: Codable, Hashable {
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}

// MARK: - Dates
struct Dates: Codable, Hashable {
    let posted, taken: String
    let takengranularity: Int
    let takenunknown, lastupdate: String
}

// MARK: - Notes
struct Notes: Codable, Hashable {
    let note: [String]
}


// MARK: - Tags
struct Tags: Codable, Hashable {
    let tag: [Tag]
}

// MARK: - Tag
struct Tag: Codable, Hashable {
    let id: String
    let author: String
    let authorname: String?
    let raw, content: String
    
    enum CodingKeys: String, CodingKey {
        case id, author, authorname, raw
        case content = "_content"
    }
}


