//
//  AppFlowCoordinator.swift
//  Doggos
//
//  Created by Alexander on 3/14/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

final class AppFlowCoordinator: DoggosRouter {
  private let window: UIWindow
  weak var transitionHandler: DoggosViperModuleTransitionHandler!

  // MARK: - Lifecycle

  init() {
    self.window = UIWindow(frame: UIScreen.main.bounds)
  }

  // MARK: - Private functions

  private func setupRootViewController() {
    let rootNavigationController = UINavigationController()
    transitionHandler = rootNavigationController
    window.rootViewController = rootNavigationController
    window.makeKeyAndVisible()
  }

  // MARK: - Internal functions

  func start() {
    self.setupRootViewController()
    transitFromAnyToNewBreedListModule()
  }
}
