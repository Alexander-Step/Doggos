//
//  AppDelegateStorage.swift
//  Doggos
//
//  Created by Alexander on 4/20/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

final class AppDelegateStorage {
  let appFlowCoordinator = AppFlowCoordinator()
  let persistentSaveTasksExecuter: PersistentSaveTasksExecuter
  
  // MARK: - Lifecycle
  
  init() {
    self.persistentSaveTasksExecuter = PersistentSaveTasksExecuter()
  }
  
  init(persistentSaveTasksExecuterMock: PersistentSaveTasksExecuter) {
    self.persistentSaveTasksExecuter = persistentSaveTasksExecuterMock
  }
}
