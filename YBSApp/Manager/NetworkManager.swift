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
    let key = "c2ee27bd86a677482c8d53cbbdd86f2b"
    let cache = NSCache<NSString, UIImage>()
    
    init() {
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getImages(of: String, page: Int) async throws -> ([FlickrPhoto]?, hasMorePages: Bool) {
        let urlString = FlickrURL.baseSearchURL.rawValue + key + "&text=\(of)&page=\(page)"
        guard let url = URL(string: urlString) else { throw YBSError.invalidURL }
        var hasMore = true
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw YBSError.serverError }
        
        do {
            let result = try decoder.decode(FlickrSearchResults.self, from: data)
            if result.photos?.page == result.photos?.pages {
                hasMore = false
            }
            return (result.photos?.photo, hasMore)
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
            return user
        } catch {
            print(error)
            throw YBSError.unableToCompleteRequest
        }
    }
    
    
    func getPhotoDetails(photo: FlickrPhoto) async throws -> FlickrPhotoDetails {
        let photoID = photo.id
        
        let formatString = FlickrURL.baseImageInfoURL.rawValue
        let urlString = String(format: formatString, key, photoID)
        guard let url = URL(string: urlString) else { throw YBSError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)

        do {
            let details = try decoder.decode(FlickrPhotoDetails.self, from: data)
            return details
        } catch {
            throw YBSError.decodingFailed
        }
    }
    
    
    func getUserPhotos(userID: String, page: Int) async throws -> ([FlickrPhoto]?, hasMorePages: Bool) {
        guard let url = URL(string: FlickrURL.baseUserImagesURL.rawValue + key + "&user_id=\(userID)&page=\(page)") else { throw YBSError.invalidURL }
        var hasMore = true
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw YBSError.serverError }
        
        do {
            let result = try decoder.decode(FlickrSearchResults.self, from: data)
            if result.photos?.page == result.photos?.pages {
                hasMore = false
            }
            return (result.photos?.photo, hasMore)
        } catch {
            throw YBSError.decodingFailed
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
