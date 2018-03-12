//
//  ImagesRemoteServiceTests.swift
//  DoggosTests
//
//  Created by Alexander on 5/25/18.
//  Copyright © 2018 None. All rights reserved.
//

import XCTest
import Moya
import PromiseKit

@testable import Doggos

class ImagesRemoteServiceTests: XCTestCase {

  let imagesRemoteService = ImagesRemoteService(DoggosMoyaProvider<DoggosAPI>(stubClosure: MoyaProvider.immediatelyStub))
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testLoadBreedImagesLinks() {
    // given
    let uplineBreed = BreedStorage(name: "Hound", subbreeds: nil, images: nil) as Breed
    let expectationOfImages = expectation(description: "Images are loaded")
    
    // when
    imagesRemoteService.loadBreedImagesLinks(uplineBreed)
      .then { (_) -> Void in
        expectationOfImages.fulfill()
        
      }.catch { (error) in
        XCTFail("Breed images wasn't loaded: \(error)")
    }
    
    // then
    waitForExpectations(timeout: expectationAwaitingTimeForImmediateStub, handler: nil)
  }
  
  func testLoadSubbreedImagesLinks() {
    // given
    let uplineBreed = BreedStorage(name: "Hound", subbreeds: nil, images: nil) as Breed
    let subbreed = SubbreedStorage(name: "blood", imagesLinks: nil) as Subbreed
    let expectationOfImages = expectation(description: "Images are loaded")
    
    // when
    imagesRemoteService.loadSubbreedImagesLinks(breed: uplineBreed, subbreed: subbreed)
      .then { (_) -> Void in
        expectationOfImages.fulfill()
        
      }.catch { (error) in
        XCTFail("Subbreed images wasn't loaded: \(error)")
    }
    
    // then
    waitForExpectations(timeout: expectationAwaitingTimeForImmediateStub, handler: nil)
  }
    
}
