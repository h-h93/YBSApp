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
    let key = ProcessInfo.processInfo.environment["FLICKR_API_KEY"]!
    let cache = NSCache<NSString, UIImage>()
    
    init() {
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getImages(of: String, page: Int) async throws -> [FlickrPhoto]? {
        let urlString = FlickrURL.baseSearchURL.rawValue + key + "&text=\(of)&page=\(page)"
        guard let url = URL(string: urlString) else { throw YBSError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw YBSError.serverError }
        
        do {
            var result = try decoder.decode(FlickrSearchResults.self, from: data)
            guard let photos = result.photos else { return nil }
            
            for (index,item) in photos.photo.enumerated() {
                let user = try await getUserDetails(userID: item.owner)
                let name = user.person.username.values.first!
                result.photos?.photo[index].setUsername(username: name)
            }
            return result.photos?.photo
        } catch {
            throw YBSError.decodingFailed
        }
    }
    
    
    func getUserDetails(userID: String) async throws -> UserProfile {
        let urlString = FlickrURL.baseSearchUserURL.rawValue + key + "&user_id=\(userID)"
        guard let url = URL(string: urlString) else { throw YBSError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw YBSError.serverError }
        
        do {
            let user = try decoder.decode(UserProfile.self, from: data)
            //print(user.person)
            return user
            //print("User \(user)")
            //try await getUserPhotos(userID: userID, page: 1)
        } catch {
            print(error)
            throw YBSError.unableToCompleteRequest
        }
    }
    
    
    func getUserPhotos(userID: String, page: Int) async throws {
        //user_id=
        guard let url = URL(string: FlickrURL.baseUserImagesURL.rawValue + key + "&user_id=\(userID)&page=\(page)") else { throw YBSError.invalidURL }
        
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw YBSError.serverError }
        
        do {
            let photos = try decoder.decode(FlickrSearchResults.self, from: data)
        } catch {
            print(error)
        }
    }
    
    
    func downloadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
