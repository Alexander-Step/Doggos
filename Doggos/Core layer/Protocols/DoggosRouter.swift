//
//  DoggosRouter.swift
//  Doggos
//
//  Created by Alexander on 3/14/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

protocol DoggosRouter {
  var transitionHandler: DoggosViperModuleTransitionHandler! { get }
}

extension DoggosRouter {
  
  func transitFromAnyToNewBreedListModule() {
    let doggoTypesListViewController = DoggoTypeListViewController()
    let breedListConfigurator = BreedListModuleConfigurator()
    breedListConfigurator.configureModuleForViewInput(viewInput: doggoTypesListViewController)
    transitionHandler.showNewViewControllerUsingDefaultPattern(doggoTypesListViewController, animated: true)
  }
  
  func transitFromAnyToNewSubbreedListModule(uplineBreed: Breed) {
    let doggoTypesListViewController = DoggoTypeListViewController()
    let subbreedListConfigurator = SubbreedListModuleConfigurator()
    subbreedListConfigurator.configureModuleForViewInput(viewInput: doggoTypesListViewController,
                                                         uplineBreed: uplineBreed)
    transitionHandler.showNewViewControllerUsingDefaultPattern(doggoTypesListViewController, animated: true)
  }
  
}
