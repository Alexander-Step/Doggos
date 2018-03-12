//
//  DoggosViperModuleTransitionHandler.swift
//  Doggos
//
//  Created by Alexander on 3/14/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

protocol DoggosViperModuleTransitionHandler: class {
  func closeCurrentModule(animated: Bool)
  func showNewViewControllerUsingDefaultPattern(_ viewController: UIViewController, animated: Bool)
  func showModallyNewViewControllerThatUsesCustomTransitioningDelegate(_ viewController: UIViewController, animated: Bool)
}

extension UIViewController: DoggosViperModuleTransitionHandler {
  
  // MARK: - Private
  private func haveManyControllersInStack() -> Bool {
    guard let existingParentViewController = parent else {
      return false
    }
    let viewControllersInStackCount: Int = existingParentViewController.childViewControllers.count
    if viewControllersInStackCount > 1 {
      return true
    } else {
      return false
    }
  }

  // MARK: - Internal
  func closeCurrentModule(animated: Bool) {
    let isInNavigationStack: Bool = parent is UINavigationController
    let hasManyControllersInStack = haveManyControllersInStack()

    if isInNavigationStack, hasManyControllersInStack {
      if let parentNavigationController = parent as? UINavigationController {
        parentNavigationController.popViewController(animated: animated)
      } else {
        print("Parent view controller is not navigation controller")
      }
    } else if let existingPresentingViewController = presentingViewController {
      existingPresentingViewController.dismiss(animated: animated, completion: nil)
    } else if view.superview != nil {
      removeFromParentViewController()
      view.removeFromSuperview()
    }
  }

  func showNewViewControllerUsingDefaultPattern(_ viewController: UIViewController, animated: Bool) {
    if let selfAsNavigationController = self as? UINavigationController {
      selfAsNavigationController.pushViewController(viewController, animated: animated)
    } else {
      self.navigationController?.pushViewController(viewController, animated: animated)
    }
  }
  
  func showModallyNewViewControllerThatUsesCustomTransitioningDelegate(_ viewController: UIViewController, animated: Bool) {
    present(viewController, animated: animated)
  }
}
