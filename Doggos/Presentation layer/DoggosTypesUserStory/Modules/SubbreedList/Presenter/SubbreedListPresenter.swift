//
//  SubbreedListSubbreedListPresenter.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 27/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

class SubbreedListPresenter {

    weak var view: DoggoTypeListViewInput!
    var interactor: SubbreedListInteractorInput!
    var router: SubbreedListRouterInput!
    var presenterStateStorage: SubbreedListPresenterStateStorage!

}

// MARK: - DoggoTypeListViewOutput
extension SubbreedListPresenter: DoggoTypeListViewOutput {
  
  func viewIsReady() {
    view.configureTitleForSubbredList(of: presenterStateStorage.uplineBreed)
    interactor.obtainSubbreeds(breed: presenterStateStorage.uplineBreed)
  }
  
  func didTapCell(with doggoType: DoggoType) {
    guard let subbreed = doggoType as? Subbreed else {
      view.showError(ModuleInternalError.castError)
      return
    }
    router.openImagesModule(breed: presenterStateStorage.uplineBreed,
                            subbreed: subbreed)
  }
  
  func didChoseToIncludeSubbreeds() {
    view.showError(ModuleInternalError.logicError)
  }
  
  func didChoseToExcludeSubbreeds() {
    view.showError(ModuleInternalError.logicError)
  }
  
  func didTapOpenSelectFlowScreen() {
    view.showError(ModuleInternalError.logicError)
  }
  
  func didTapCloseTypesFlowSelectionView() {
    view.showError(ModuleInternalError.logicError)
  }
  
}

// MARK: - SubbreedListInteractorOutput
extension SubbreedListPresenter: SubbreedListInteractorOutput {
  
  func didObtainSubbreeds(_ subbreeds: [Subbreed]) {
    let doggoTypes = subbreeds as [DoggoType]
    if !doggoTypes.isEmpty {
      view.configure(with: doggoTypes)
    } else {
      view.showError(ModuleInternalError.noSubbreedsFound)
    }
    
  }
  
  func couldNotObtainSubbreeds(_ error: Error?) {
    view.showError(error)
  }
  
}

// MARK: - SubbreedListModuleInput
extension SubbreedListPresenter: SubbreedListModuleInput {
  
}
