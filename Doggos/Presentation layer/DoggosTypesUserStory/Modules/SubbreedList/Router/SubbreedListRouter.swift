//
//  SubbreedListSubbreedListRouter.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 27/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

class SubbreedListRouter {
	weak var transitionHandler: DoggosViperModuleTransitionHandler!
}

// MARK: - SubbreedListRouterInput
extension SubbreedListRouter: SubbreedListRouterInput {
  
  func openImagesModule(breed: Breed, subbreed: Subbreed) {
    let imagesViewController = ImagesCollectionViewController()
    let imagesConfigurator = ImagesCollectionModuleConfigurator()
    imagesConfigurator.configureModuleForViewInput(viewInput: imagesViewController,
                                                   breed: breed,
                                                   subbreed: subbreed)
    transitionHandler.showNewViewControllerUsingDefaultPattern(imagesViewController,
                                                               animated: true)
  }

}
