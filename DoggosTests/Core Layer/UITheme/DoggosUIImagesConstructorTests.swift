//
//  DoggosUIImagesConstructorTests.swift
//  DoggosTests
//
//  Created by Alexander on 6/26/18.
//  Copyright © 2018 None. All rights reserved.
//

import XCTest
@testable import Doggos

class DoggosUIImagesConstructorTests: XCTestCase {
  
    override func setUp() {
        super.setUp()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    func testDoggoTypeCellBackgroundImageThrowing() {
        XCTAssertNoThrow(try ImagesConstructorMock.doggoTypeCellBackgroundImageThrowing(),
                         "Could not instanciate doggoTypeCellBackgroundImage")
    }
  
    func testNavBarBackgroundImageThrowing() {
      XCTAssertNoThrow(try ImagesConstructorMock.navBarBackgroundImageThrowing(),
                       "Could not instanciate navBarBackgroundImage")
    }
  
    func testCrossImageThrowing() {
      XCTAssertNoThrow(try ImagesConstructorMock.crossImageThrowing(),
                       "Could not instanciate testCrossImage")
    }
  
    func testSelectFlowBackgroundGradientThrowing() {
      XCTAssertNoThrow(try ImagesConstructorMock.selectFlowBackgroundGradientThrowing(),
                       "Could not instanciate selectFlowBackgroundGradient image")
    }
  
    func testDoggoFaceThrowing() {
      XCTAssertNoThrow(try ImagesConstructorMock.doggoFaceThrowing(),
                       "Could not instanciate doggoFace image")
    }

    // MARK: - ImagesConstructorMock
    class ImagesConstructorMock: DoggosUIImagesConstructTasksExecuter {
      
    }
    
}
