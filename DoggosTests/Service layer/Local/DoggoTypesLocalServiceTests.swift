//
//  DoggoTypesLocalServiceTests.swift
//  DoggosTests
//
//  Created by Alexander on 5/29/18.
//  Copyright © 2018 None. All rights reserved.
//

import XCTest
@testable import Doggos
import CoreData
import PromiseKit

class DoggoTypesLocalServiceTests: XCTestCase, AppDelegateAccessor {
    let doggoTypesLocalService = DoggoTypesLocalService()
  
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
    func testSaveBreeds() {
      // given
      let testBreed1 = BreedStorage(name: "TestBreedName1", subbreeds: nil, images: nil) as Breed
      let testBreed2 = BreedStorage(name: "TestBreedName2", subbreeds: nil, images: nil) as Breed
      let expectationOfTypes = expectation(description: "Breeds was saved")
      
      // when
      doggoTypesLocalService.save(breeds: [testBreed1, testBreed2])
        .then { (breeds) -> Void in
          XCTAssert(breeds.count == 2, "Saved breeds count is not correct. SavedBreeds: \(breeds)")
          expectationOfTypes.fulfill()
          
        }.catch { (error) in
          XCTFail("Could not save breeds to database: \(error)")
      }
      
      // then
      waitForExpectations(timeout: expectationAwaitingTimeForImmediateStub, handler: nil)
    }
    
    func testFetchBreeds() {
      // given
      let testBreed = BreedStorage(name: "TestBreedName", subbreeds: nil, images: nil) as Breed
      let expectationOfTypes = expectation(description: "Saved breed was fetched")

      // when
      doggoTypesLocalService.save(breeds: [testBreed])
        .then { (savedBreeds) -> Promise<[Breed]> in
          XCTAssert(savedBreeds.count == 1, "Saved breeds count is not correct. SavedBreeds: \(savedBreeds)")
          return self.doggoTypesLocalService.fetchBreeds()
          
        }.then { (breeds) -> Void in
          XCTAssert(breeds.count == 1, "Fetched breeds after save count is not correct. Breeds: \(breeds)")
          expectationOfTypes.fulfill()
          
        }.catch { (error) in
          XCTFail("Could not fetch breeds from database: \(error)")
      }
      
      // then
      waitForExpectations(timeout: expectationAwaitingTimeForImmediateStub, handler: nil)
    }
  
  func testSaveSubbreeds() {
    // given
    let testBreed1 = BreedStorage(name: "TestBreedName1", subbreeds: nil, images: nil) as Breed
    let testSubbreed1 = SubbreedStorage(name: "TestSubbreedName1", imagesLinks: nil) as Subbreed
    let testSubbreed2 = SubbreedStorage(name: "TestSubbreedName2", imagesLinks: nil) as Subbreed
    let expectationOfSubbreeds = expectation(description: "Breeds was saved")
    
    // when
    doggoTypesLocalService.save(breeds: [testBreed1])
      .then { (savedBreeds) -> Promise<[Subbreed]> in
        XCTAssert(savedBreeds.count == 1, "Saved breeds count is not correct. SavedBreeds: \(savedBreeds)")
        return self.doggoTypesLocalService.save(subbreeds: [testSubbreed1, testSubbreed2],
                                                uplineBreed: testBreed1)
      }.then { (savedSubbreeds) -> Void in
        XCTAssert(savedSubbreeds.count == 2, "Saved subbreeds count is not correct. SavedSubbreeds: \(savedSubbreeds)")
        expectationOfSubbreeds.fulfill()
        
      }.catch { (error) in
        XCTFail("Could not save subbreeds with uplineBreed to database: \(error)")
    }
    
    // then
    waitForExpectations(timeout: expectationAwaitingTimeForImmediateStub, handler: nil)
  }
  
  func testFetchSubbreeds() {
    // given
    let testBreed1 = BreedStorage(name: "TestBreedName1", subbreeds: nil, images: nil) as Breed
    let testSubbreed1 = SubbreedStorage(name: "TestSubbreedName1", imagesLinks: nil) as Subbreed
    let testSubbreed2 = SubbreedStorage(name: "TestSubbreedName2", imagesLinks: nil) as Subbreed
    let expectationOfSubbreeds = expectation(description: "Breeds was saved")
    
    // when
    doggoTypesLocalService.save(breeds: [testBreed1])
      .then { (breeds) -> Promise<[Subbreed]> in
        XCTAssert(breeds.count == 1, "Saved breeds count is not correct. SavedBreeds: \(breeds)")
        return self.doggoTypesLocalService.save(subbreeds: [testSubbreed1, testSubbreed2],
                                                uplineBreed: testBreed1)
        
      }.then { (subbreeds) -> Promise<[Subbreed]> in
        XCTAssert(subbreeds.count == 2, "Saved subbreeds count is not correct. Subbreeds: \(subbreeds)")
        return self.doggoTypesLocalService.fetchSubbreeds(uplineBreed: testBreed1)
    
      }.then { (subbreeds) -> Void in
        XCTAssert(subbreeds.count == 2, "Fetched subbreeds after save count is not correct. Subbreeds: \(subbreeds)")
        print("Fetched subbreeds: \(subbreeds)")
        expectationOfSubbreeds.fulfill()
        
      }.catch { (error) in
        XCTFail("Could not save subbreeds with uplineBreed to database: \(error)")
    }
    
    // then
    waitForExpectations(timeout: expectationAwaitingTimeForImmediateStub, handler: nil)
  }
  
}
