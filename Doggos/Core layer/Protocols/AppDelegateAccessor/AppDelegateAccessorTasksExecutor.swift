//
//  AppDelegateAccessorTasksExecutor.swift
//  Doggos
//
//  Created by Alexander on 6/26/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

protocol AppDelegateAccessorTasksExecutor {
}

extension AppDelegateAccessorTasksExecutor {
  
  func obtainAppDelegateBeingONTheMainThread() throws -> AppDelegate {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
      else { throw ModuleInternalError.castError }
    return appDelegate
  }
  
  func obtainAppDelegateBeingNOTOnTheMainThread() throws -> AppDelegate {
    return try DispatchQueue.main.sync { () -> AppDelegate in
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { throw ModuleInternalError.castError }
      return appDelegate
    }
  }
}
