//
//  ImageDetailsImageDetailsRouter.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 30/05/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

class ImageDetailsRouter {
	weak var transitionHandler: DoggosViperModuleTransitionHandler!
}

// MARK: - ImageDetailsRouterInput
extension ImageDetailsRouter: ImageDetailsRouterInput {
	
  func closeModule() {
    transitionHandler.closeCurrentModule(animated: true)
  }

}
