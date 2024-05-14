//
//  YBSAppTests.swift
//  YBSAppTests
//
//  Created by hanif hussain on 08/05/2024.
//

import XCTest
@testable import YBSApp

final class YBSAppTests: XCTestCase {

    override func setUpWithError() throws {
        
    }
    

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    

    func testNetworkingCode() throws {
        // userID 164798111@N07
        
    }
    
    
    func test_getImages_success() async {
        do {
            let (photos, hasMorePages) = try await NetworkManager.shared.getImages(of: "Yorkshire", page: 1)
            await test_getPhotoDetails_success(photo: photos!.first!)
            try await test_downloadImage_success(imageURL: photos!.first!.imageURL)
            XCTAssertNotNil(photos)
            XCTAssertTrue(hasMorePages)
            XCTAssertEqual(photos?.count, 20)
        } catch {
            
        }
    }
    
    
    func test_getUserDetails_success() async {
        do {
            let userDetails = try await NetworkManager.shared.getUserDetails(userID: "164798111@N07")
            
            XCTAssertNotNil(userDetails)
            XCTAssertEqual(userDetails.person.id, "164798111@N07")
        } catch {
            
        }
    }
    
    
    func test_getUserDetails_invalidURL() async {
        do {
            _ = try await NetworkManager.shared.getUserDetails(userID: "ybsapptestexample")
            XCTFail("Error needs to be thrown")
        } catch {
            // Do nothing we are testing to see if error is thrown
        }
    }
    
    
    func test_getPhotoDetails_success(photo: FlickrPhoto) async {
        do {
            let photoDetails = try await NetworkManager.shared.getPhotoDetails(photo: photo)
            XCTAssertNotNil(photoDetails)
        } catch {
            
        }
    }
    
    
    func test_getUserPhotos_success() async {
        do {
            let (photos, hasMorePages) = try await NetworkManager.shared.getUserPhotos(userID: "164798111@N07", page: 1)
            
            XCTAssertNotNil(photos)
            XCTAssertTrue(hasMorePages)
            XCTAssertEqual(photos?.count, 20)
        } catch {
            
        }
    }
    
    
    func test_getUserPhotos_invalidID() async {
        //let expectation = expectation(description: "expect call to throw error")
        do {
            let (photos, hasMorePages) = try await NetworkManager.shared.getUserPhotos(userID: "ybsapptestexample", page: 1)
            XCTAssertNil(photos)
        } catch {
        }
    }
    
    
    func test_downloadImage_success(imageURL: String) async throws {
        let image = await NetworkManager.shared.downloadImage(from: imageURL)
        XCTAssertNotNil(image)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
