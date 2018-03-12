//
//  BreedListBreedListPresenter.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 14/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

class BreedListPresenter {

  weak var view: DoggoTypeListViewInput!
  var interactor: BreedListInteractorInput! // WEAK FOR TEST
  var router: BreedListRouterInput!
  var presenterStateStorage: BreedListPresenterStateStorage!

}

// MARK: - BreedListViewOutput
extension BreedListPresenter: DoggoTypeListViewOutput {
	func viewIsReady() {
    view.configureNavigationItemForBreedList()
    view.configureTitleForBreedList()
    interactor.obtainBreeds()
  }
  
  func didTapCell(with doggoType: DoggoType) {
    guard let breed = doggoType as? Breed else {
      view.showError(ModuleInternalError.castError)
      return
    }
    if presenterStateStorage.includeSubbreeds {
      interactor.obtainSubbreedsForTransitionValidation(breed: breed)
    } else {
      router.openImagesModule(breed: breed)
    }
  }
  
  func didTapOpenSelectFlowScreen() {
    view.showSelectFlowScreen(includeSubbreedsSetting: presenterStateStorage.includeSubbreeds)
  }
  
  func didChoseToIncludeSubbreeds() {
    presenterStateStorage.includeSubbreeds = true
  }
  
  func didChoseToExcludeSubbreeds() {
    presenterStateStorage.includeSubbreeds = false
  }
  
  func didTapCloseTypesFlowSelectionView() {
    view.removeTypesFlowSelectionView()
  }

}

// MARK: - BreedListInteractorOutput
extension BreedListPresenter: BreedListInteractorOutput {
  
  func didObtainBreeds(_ breeds: [Breed]) {
    view.configure(with: breeds as [DoggoType])
  }
  
  func couldNotObtainBreeds(_ error: Error?) {
    view.showError(error)
  }
  
  func didObtainSubbreedsForTransitionValidation(subbreeds: [Subbreed], uplineBreed: Breed) {
    if !subbreeds.isEmpty {
      router.openSubbreedListModule(uplineBreed: uplineBreed)
    } else {
      view.showError(ModuleInternalError.noSubbreedsFound)
    }
  }
  
  func couldNotObtainSubbreedsForTransitionValidation(_ error: Error) {
    view.showError(error)
  }
  
}

// MARK: - BreedListModuleInput
extension BreedListPresenter: BreedListModuleInput {
}
