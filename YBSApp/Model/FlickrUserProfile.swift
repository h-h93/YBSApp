// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct UserProfile: Codable {
    let person: Person
    let stat: String
}


// MARK: - Person
struct Person: Codable {
    let id, nsid: String
    let username: [String : String]
    let realname, location: [String : String]?
    let description, photosurl, profileurl, mobileurl: [String: String]?
    let photos: UserPhotos
}


// MARK: - Photos
struct UserPhotos: Codable {
    let firstdatetaken, firstdate: [String: String]?
    let count: [String: Int]?
}

