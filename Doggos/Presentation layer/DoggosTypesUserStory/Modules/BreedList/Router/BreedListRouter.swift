//
//  BreedListBreedListRouter.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 14/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

class BreedListRouter: DoggosRouter {
	weak var transitionHandler: DoggosViperModuleTransitionHandler!
}

// MARK: - BreedListRouterInput
extension BreedListRouter: BreedListRouterInput {
  
  func openSubbreedListModule(uplineBreed: Breed) {
    transitFromAnyToNewSubbreedListModule(uplineBreed: uplineBreed)
  }
  
  func openImagesModule(breed: Breed) {
    let imagesViewController = ImagesCollectionViewController()
    let imagesConfigurator = ImagesCollectionModuleConfigurator()
    imagesConfigurator.configureModuleForViewInput(viewInput: imagesViewController,
                                                   breed: breed,
                                                   subbreed: nil)
    transitionHandler.showNewViewControllerUsingDefaultPattern(imagesViewController,
                                                               animated: true)
  }
  
}
