//
//  ImagesCollectionImagesCollectionPresenter.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 06/04/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import UIKit

class ImagesCollectionPresenter {

  weak var view: ImagesCollectionViewInput!
  var interactor: ImagesCollectionInteractorInput!
  var router: ImagesCollectionRouterInput!
  var presenterStateStorage: ImagesCollectionPresenterStateStorage!

}

// MARK: - ImagesCollectionViewOutput
extension ImagesCollectionPresenter: ImagesCollectionViewOutput {
	
  func viewIsReady() {
    interactor.obtainImageLinks(breed: presenterStateStorage.breed,
                                subbreed: presenterStateStorage.subbreed)
  }
  
  func didTapCellWith(image: UIImage, viewContainingImage: UIView) {
    router.openImageDetailsModule(image: image, viewContainingImage: viewContainingImage)
  }

}

// MARK: - ImagesCollectionInteractorOutput
extension ImagesCollectionPresenter: ImagesCollectionInteractorOutput {
  
  func didObtainImageLinks(_ imageLinks: [ImageLinkContainer]) {
    view.configure(with: imageLinks)
  }
  
  func couldNotObtainImageLinks(_ error: Error) {
    view.showError(error)
  }
  
}

// MARK: - ImagesCollectionModuleInput
extension ImagesCollectionPresenter: ImagesCollectionModuleInput {
	
}
