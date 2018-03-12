//
//  AppConfigurator.swift
//  Doggos
//
//  Created by Alexander on 4/20/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

final class AppConfigurator: AppDelegateAccessor {
  func configureApp() {
    setupCoreDataStack()
  }
}

// MARK: - Private
extension AppConfigurator {
  
  private func setupCoreDataStack() {
    let appDelegate = obtainAppDelegate()
    appDelegate.appDelegateStorage.persistentSaveTasksExecuter.setupCoreDataStack()
  }
  
}
