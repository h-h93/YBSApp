//
//  Constants.swift
//  YBSApp
//
//  Created by hanif hussain on 08/05/2024.
//

import UIKit

enum FlickrURL: String {
    case baseSearchURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&per_page=20&safe_search=1&api_key="
    
    case baseSearchUserURL = "https://api.flickr.com/services/rest/?&method=flickr.people.getInfo&format=json&nojsoncallback=1&api_key="
    
    case baseUserImagesURL = "https://api.flickr.com/services/rest/?&method=flickr.people.getPhotos&format=json&nojsoncallback=1&safe_search=1&per_page=20&api_key="
    
    case baseImageInfoURL = "https://api.flickr.com/services/rest/?&method=flickr.photos.getInfo&format=json&nojsoncallback=1&safe_search=1&per_page=20&api_key=%@&photo_id=%@"
    
    case imageURL = "https://farm%d.staticflickr.com/%@/%@_%@.jpg"
    
    case profileImageURL = "https://farm%@.staticflickr.com/%@/buddyicons/%@.jpg"
}


enum Images {
    static let defaultImage = UIImage(systemName: "photo")
}
