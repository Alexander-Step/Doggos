//
//  DoggoTypesRemoteServiceTests.swift
//  DoggosTests
//
//  Created by Alexander on 5/25/18.
//  Copyright © 2018 None. All rights reserved.
//

import XCTest
import Moya
import PromiseKit
@testable import Doggos

let expectationAwaitingTimeForImmediateStub: TimeInterval = 0.4

class DoggoTypesRemoteServiceTests: XCTestCase {
  
  let doggoTypesRemoteService = DoggoTypesRemoteService(DoggosMoyaProvider<DoggosAPI>.init(stubClosure: MoyaProvider.immediatelyStub))
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
      super.tearDown()
  }
    
  func testLoadBreedList() {
    // given
    let expectationOfBreeds = expectation(description: "Breeds are loaded")
    
    // when
    doggoTypesRemoteService.loadBreedList()
      .then { (_) -> Void in
        expectationOfBreeds.fulfill()
        
      }.catch { (error) in
        XCTFail("Could not load breed list: \(error)")
    }
    
    // then
    waitForExpectations(timeout: expectationAwaitingTimeForImmediateStub, handler: nil)
  }
  
  func testLoadSubbreedsList() {
    // given
    let uplineBreed = BreedStorage(name: "Hound", subbreeds: nil, images: nil) as Breed
    let expectationOfSubbreeds = expectation(description: "Subbreeds are loaded")
    
    // when
    doggoTypesRemoteService.loadSubbreedList(breed: uplineBreed)
      .then { (_) -> Void in
        expectationOfSubbreeds.fulfill()
        
      }.catch { (error) in
        XCTFail("Could not load subbreed list for breed: \(uplineBreed). \n Error: \(error)")
    }
    
    // then
    waitForExpectations(timeout: expectationAwaitingTimeForImmediateStub, handler: nil)
  }
  
}
