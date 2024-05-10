//
//  Constants.swift
//  YBSApp
//
//  Created by hanif hussain on 08/05/2024.
//

import UIKit

enum FlickrURL: String {
//    case baseSearchURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key="
//    
//    case baseSearchURLAttachment = "&format=json&nojsoncallback=1&safe_search=1&per_page=20&"
    
    case baseSearchURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&per_page=20&safe_search=1&api_key="
    
    case baseSearchUserURL = "https://api.flickr.com/services/rest/?&method=flickr.people.getInfo&format=json&nojsoncallback=1&api_key="
    
    case baseUserImagesURL = "https://api.flickr.com/services/rest/?&method=flickr.people.getPhotos&format=json&nojsoncallback=1&safe_search=1&per_page=20&api_key="
    
    case imageURL = "https://farm%d.staticflickr.com/%@/%@_%@.jpg"
    
    //http://farm9.staticflickr.com/8573/buddyicons/116479554@N04.jpg
    
    //"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key!)&format=json&nojsoncallback=1&safe_search=1&per_page=10&text=Cats&page=1"
    
    
    //https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=b5ac9d3806013e2f380e117220d60424&format=json&nojsoncallback=1&safe_search=1&per_page=10&text=Cats&page=1
    
    
    // get the specific users photos
    //https://api.flickr.com/services/rest/?&method=flickr.people.getPhotos&api_key=b5ac9d3806013e2f380e117220d60424&user_id=55929728@N03&format=json&per_page=4
    
    
    // get users information based on nsid
    //https://api.flickr.com/services/rest/?&method=flickr.people.getInfo&api_key=b5ac9d3806013e2f380e117220d60424&user_id=164798111@N07&format=json&per_page=4
}


enum Images {
    static let defaultImage = UIImage(systemName: "photo")
}
