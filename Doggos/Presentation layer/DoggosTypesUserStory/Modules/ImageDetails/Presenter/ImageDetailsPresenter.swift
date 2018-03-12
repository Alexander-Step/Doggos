//
//  ImageDetailsImageDetailsPresenter.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 30/05/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

class ImageDetailsPresenter {

    weak var view: ImageDetailsViewInput!
    var interactor: ImageDetailsInteractorInput!
    var router: ImageDetailsRouterInput!
    var presenterStateStorage: ImageDetailsPresenterStateStorage!

}

// MARK: - ImageDetailsViewOutput
extension ImageDetailsPresenter: ImageDetailsViewOutput {
	
	func viewIsReady() {
    view.configure(with: presenterStateStorage.image)
  }
  
  func backButtonTapped() {
    router.closeModule()
  }

}

// MARK: - ImageDetailsInteractorOutput
extension ImageDetailsPresenter: ImageDetailsInteractorOutput {
	
}

// MARK: - ImageDetailsModuleInput
extension ImageDetailsPresenter: ImageDetailsModuleInput {
  
}
