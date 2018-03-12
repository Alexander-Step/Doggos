//
//  AppDelegateAccesserTests.swift
//  DoggosTests
//
//  Created by Alexander on 5/18/18.
//  Copyright © 2018 None. All rights reserved.
//

import XCTest
@testable import Doggos

class AppDelegateAccessorTasksExecuterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testObtainAppDelegateOnTheMainThread() {
      // given
      let appDelegateAccessorTasksExecuterMock = AppDelegateAccessorTasksExecuterMock()
      var appDelegate: AppDelegate?
      
      // when
      appDelegate = try? appDelegateAccessorTasksExecuterMock.obtainAppDelegateBeingONTheMainThread()
      
      // then
      XCTAssertNoThrow(try appDelegateAccessorTasksExecuterMock.obtainAppDelegateBeingONTheMainThread(),
                       "Could not obtain app delegate being on the main thread via AppDelegateAccesserTasksExecutor(error was throwed)")
      XCTAssertNotNil(appDelegate,
                      "Could not obtain app delegate being on the main thread via AppDelegateAccesserTasksExecutor(appDelegate is nil)")
    }
  
    func testObtainAppDelegateOnTheSecondaryThread() {
      // given
      let appDelegateAccessorTasksExecuterMock = AppDelegateAccessorTasksExecuterMock()
      let expectationOfAppDelegate = expectation(description: "AppDelegate was obtained")
      var appDelegate: AppDelegate?
      
      let obtainAppDelegateClosure: () -> Void = {
        DispatchQueue.global(qos: .default).async {
          do {
            appDelegate = try appDelegateAccessorTasksExecuterMock.obtainAppDelegateBeingNOTOnTheMainThread()
            XCTAssertNotNil(appDelegate,
                            "Could not obtain app delegate being on the secondary thread via AppDelegateAccesserTasksExecutor(appDelegate is nil)")
            expectationOfAppDelegate.fulfill()
            
          } catch {
            XCTFail("Could not obtain app delegate being on the secondary thread via AppDelegateAccesserTasksExecutor(error was throwed)")
          }
        }
      }
      
      // when
      obtainAppDelegateClosure()
      
      // then
      waitForExpectations(timeout: expectationAwaitingTimeForImmediateStub, handler: nil)

    }
  
    class AppDelegateAccessorTasksExecuterMock: AppDelegateAccessorTasksExecutor {
    }
    
}
