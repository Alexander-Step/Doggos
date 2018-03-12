//
//  AppDelegate.swift
//  Doggos
//
//  Created by Alexander on 3/12/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var appDelegateStorage = AppDelegateStorage()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let appConfigurator = AppConfigurator()
    appConfigurator.configureApp()
    appDelegateStorage.appFlowCoordinator.start()
    return true
  }

}
