//
//  NetworkManager.swift
//  YBSApp
//
//  Created by hanif hussain on 08/05/2024.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    func getImages() async throws {
        let key = ProcessInfo.processInfo.environment["FLICKR_API_KEY"]
        let searchURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key)&format=json&nojsoncallback=1&safe_search=1&per_page=\(60)&text=%@&page=%ld"
        

    }
}
