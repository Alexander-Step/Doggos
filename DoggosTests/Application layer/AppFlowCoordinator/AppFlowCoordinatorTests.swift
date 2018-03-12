//
//  AppFlowCoordinatorTests.swift
//  DoggosTests
//
//  Created by Alexander on 5/29/18.
//  Copyright © 2018 None. All rights reserved.
//

import XCTest
@testable import Doggos

class AppFlowCoordinatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStart() {
        // given
        let appFlowCoordinator = AppFlowCoordinator()
      
        // when
        appFlowCoordinator.start()
      
        // then
        XCTAssertNotNil(appFlowCoordinator.transitionHandler, "Transition handler of app flow coordinator is nil")
      
    }
    
}
