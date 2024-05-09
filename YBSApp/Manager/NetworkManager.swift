//
//  NetworkManager.swift
//  YBSApp
//
//  Created by hanif hussain on 08/05/2024.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    //text=%@&page=%ld
    
    init() {
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getImages(of: String, page: Int) async throws {
        guard let key = ProcessInfo.processInfo.environment["FLICKR_API_KEY"] else { throw YBSError.unableToCompleteRequest }
        let url = FlickrURL.baseSearchURL.rawValue + key + "&text=\(of)&page=\(page)"
        guard let url = URL(string: url) else { throw YBSError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw YBSError.serverError }
        
        do {
            let result = try decoder.decode(FlickrSearchResults.self, from: data)
            print(result.photos?.photo.first?.owner)
            print(result.photos?.photo.first?.imageURL)
            try await getUserDetails(userID: "164798111@N07")
        } catch {
            throw YBSError.decodingFailed
        }
    }
    
    
    func getUserDetails(userID: String) async throws {
        guard let apiKey = ProcessInfo.processInfo.environment["FLICKR_API_KEY"] else { throw YBSError.unableToCompleteRequest }
        guard let url = URL(string: FlickrURL.baseSearchUserURL.rawValue + apiKey + "&user_id=\(userID)") else { throw YBSError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw YBSError.serverError }
        
        do {
            let user = try decoder.decode(UserProfile.self, from: data)
            print("User \(user)")
        } catch {
            print(error)
        }
    }
    
    
    func getUserPhotos(userID: String) {
        
    }
}
