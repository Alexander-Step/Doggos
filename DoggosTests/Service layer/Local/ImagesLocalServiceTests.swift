//
//  ImagesLocalServiceTests.swift
//  DoggosTests
//
//  Created by Alexander on 6/21/18.
//  Copyright © 2018 None. All rights reserved.
//

import XCTest
@testable import Doggos
import CoreData
import PromiseKit

class ImagesLocalServiceTests: XCTestCase, AppDelegateAccessor {
  
  let doggoTypesLocalService = DoggoTypesLocalService()
  let imagesLocalService = ImagesLocalService()
  
  // MARK: - Lifecycle
  override func setUp() {
    super.setUp()
    setupAppDelegateStorageWithMockPersistentStore()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Helpers
  private func setupAppDelegateStorageWithMockPersistentStore() {
    let persistentContainerMock = createPersistentContainerMock()
    let persistentSaveTasksExecuterMock = PersistentSaveTasksExecuter(persistentContainerMock: persistentContainerMock)
    obtainAppDelegate().appDelegateStorage = AppDelegateStorage(persistentSaveTasksExecuterMock: persistentSaveTasksExecuterMock)
    persistentSaveTasksExecuterMock.setupCoreDataStack()
  }
  
  private func createPersistentContainerMock() -> NSPersistentContainer {
    let persistentContainerMock = NSPersistentContainer(name: "Doggos")
    let storeDescription = NSPersistentStoreDescription()
    storeDescription.type = NSInMemoryStoreType
    storeDescription.shouldAddStoreAsynchronously = false
    persistentContainerMock.persistentStoreDescriptions = [storeDescription]
    return persistentContainerMock
  }
  
  // MARK: - Tests
  func testSaveImageLinkContainersForBreed() {
    // given
    let testBreed1 = BreedStorage(name: "TestBreedName1", subbreeds: nil, images: nil) as Breed
    let testImageLinkContainer1 = ImageLinkContainer(link: "TestLink")
    let expectationOfImageLinkContainers = expectation(description: "Image link containers was saved")
    
    // when
    doggoTypesLocalService.save(breeds: [testBreed1])
      .then { (savedBreeds) -> Promise<[ImageLinkContainer]> in
        XCTAssertNotNil(savedBreeds.first, "Upline breed for image link container wasn't saved")
        if let savedBreed = savedBreeds.first {
          return self.imagesLocalService.save(linkContainers: [testImageLinkContainer1],
                                              uplineBreed: savedBreed)
        } else {
          throw LocalServiceError.couldNotSaveEntity
        }
        
      }.then { (savedImageLinkContainers) -> Void in
        XCTAssertNotNil(savedImageLinkContainers, "Image link container wasn't saved")
        XCTAssertTrue(savedImageLinkContainers.count == 1, "Count of saved image link containers is not correct")
        expectationOfImageLinkContainers.fulfill()
        
      }.catch { (error) in
        XCTFail("Could not save imagelink container for breed in database. Error: \(error) ")
    }
    
    // then
    waitForExpectations(timeout: expectationAwaitingTimeForImmediateStub, handler: nil)
  }
  
  func testSaveImageLinkContainersForSubbreed() {
    // given
    let testBreed1 = BreedStorage(name: "TestBreedName1", subbreeds: nil, images: nil) as Breed
    let testSubbreed1 = SubbreedStorage(name: "TestSubbreedName1", imagesLinks: nil) as Subbreed
    let testImageLinkContainer1 = ImageLinkContainer(link: "TestLink")
    let expectationOfImageLinkContainers = expectation(description: "Image link containers was saved")
    
    // when
    doggoTypesLocalService.save(breeds: [testBreed1])
      .then { (savedBreeds) -> Promise<[Subbreed]> in
        XCTAssertNotNil(savedBreeds.first, "Upline breed for image link container wasn't saved")
        if let savedBreed = savedBreeds.first {
          return self.doggoTypesLocalService.save(subbreeds: [testSubbreed1], uplineBreed: savedBreed)
        } else {
          throw LocalServiceError.couldNotSaveEntity
        }
      }.then { (savedSubbreeds) -> Promise<[ImageLinkContainer]> in
        XCTAssertNotNil(savedSubbreeds.first, "Upline subbreed for image link container wasn't saved")
        if let savedSubbreed = savedSubbreeds.first {
          return self.imagesLocalService.save(linkContainers: [testImageLinkContainer1],
                                              uplineSubbreed: savedSubbreed)
        } else {
          throw LocalServiceError.couldNotSaveEntity
        }
          
    }.then { (savedImageLinkContainers) -> Void in
        XCTAssertTrue(savedImageLinkContainers.count == 1, "Count of saved image link containers is not correct")
        expectationOfImageLinkContainers.fulfill()
        
      }.catch { (error) in
        XCTFail("Could not save imagelink container for breed in database. Error: \(error)")
    }
    
    // then
    waitForExpectations(timeout: expectationAwaitingTimeForImmediateStub, handler: nil)
  }
  
  func testFetchImageLinkContainersForBreed() {
    // given
    let testBreed1 = BreedStorage(name: "TestBreedName1", subbreeds: nil, images: nil) as Breed
    let testImageLinkContainer1 = ImageLinkContainer(link: "TestLink")
    let expectationOfImageLinkContainers = expectation(description: "Image link containers was saved")
    
    // when
    doggoTypesLocalService.save(breeds: [testBreed1])
      .then { (savedBreeds) -> Promise<[ImageLinkContainer]> in
        XCTAssertNotNil(savedBreeds.first, "Upline breed for image link container wasn't saved")
        if let savedBreed = savedBreeds.first {
          return self.imagesLocalService.save(linkContainers: [testImageLinkContainer1],
                                              uplineBreed: savedBreed)
        } else {
          throw LocalServiceError.couldNotSaveEntity
        }
        
      }.then { (_) -> Promise<[ImageLinkContainer]> in
        return self.imagesLocalService.fetchImageLinkContainers(breed: testBreed1)
        
      }.then { (fetchedImageLinkContainers) -> Void in
        XCTAssertTrue(fetchedImageLinkContainers.count == 1, "Count of fetched image link containers is not correct")
        expectationOfImageLinkContainers.fulfill()
        
      }.catch { (error) in
        XCTFail("Could not fetch imagelink container for breed in database. Error: \(error)")
    }
    
    // then
    waitForExpectations(timeout: expectationAwaitingTimeForImmediateStub, handler: nil)
  }
  
  func testFetchImageLinkContainersForSubbreed() {
    // given
    let testBreed1 = BreedStorage(name: "TestBreedName1", subbreeds: nil, images: nil) as Breed
    let testSubbreed1 = SubbreedStorage(name: "TestSubbreedName1", imagesLinks: nil) as Subbreed
    let testImageLinkContainer1 = ImageLinkContainer(link: "TestLink")
    let expectationOfImageLinkContainers = expectation(description: "Image link containers was saved")
    
    // when
    doggoTypesLocalService.save(breeds: [testBreed1])
      .then { (savedBreeds) -> Promise<[Subbreed]> in
        if let savedBreed = savedBreeds.first {
          return self.doggoTypesLocalService.save(subbreeds: [testSubbreed1],
                                                  uplineBreed: savedBreed)
        } else {
          throw LocalServiceError.couldNotSaveEntity
        }
        
      }.then { (savedSubbreeds) -> Promise<[ImageLinkContainer]> in
        if let savedSubbreed = savedSubbreeds.first {
          return self.imagesLocalService.save(linkContainers: [testImageLinkContainer1],
                                              uplineSubbreed: savedSubbreed)
        } else {
          throw LocalServiceError.couldNotSaveEntity
        }
        
      }.then { (_) -> Promise<[ImageLinkContainer]> in
        return self.imagesLocalService.fetchImageLinkContainers(subbreed: testSubbreed1)
        
      }.then { (fetchedImageLinkContainers) -> Void in
        XCTAssertTrue(fetchedImageLinkContainers.count == 1, "Count of fetched image link containers is not correct")
        expectationOfImageLinkContainers.fulfill()
        
      }.catch { (error) in
        XCTFail("Could not fetch imagelink container for breed in database. Error: \(error)")
    }
    
    // then
    waitForExpectations(timeout: expectationAwaitingTimeForImmediateStub, handler: nil)
  }
  
}
