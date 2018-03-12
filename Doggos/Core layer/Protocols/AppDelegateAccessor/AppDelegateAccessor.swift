//
//  AppDelegateAccessor.swift
//  Doggos
//
//  Created by Alexander on 5/18/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

protocol AppDelegateAccessor: AppDelegateAccessorTasksExecutor {
}

extension AppDelegateAccessor {
  
  /**
   Thread safe method to obtain AppDelegate reference
  */
  func obtainAppDelegate() -> AppDelegate {
    if Thread.isMainThread {
      return (try! obtainAppDelegateBeingONTheMainThread())
    } else {
      return (try! obtainAppDelegateBeingNOTOnTheMainThread())
    }
  }
  
}
