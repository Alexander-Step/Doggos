//
//  ImagesCollectionImagesCollectionConfigurator.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 06/04/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import UIKit

class ImagesCollectionModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController,
                                                       breed: Breed,
                                                       subbreed: Subbreed? = nil) {

        if let viewController = viewInput as? ImagesCollectionViewController {
          configure(viewController: viewController, breed: breed, subbreed: subbreed)
        }
    }

    private func configure(viewController: ImagesCollectionViewController,
                           breed: Breed,
                           subbreed: Subbreed?) {

        let router = ImagesCollectionRouter()
        router.transitionHandler = viewController as DoggosViperModuleTransitionHandler

        let presenter = ImagesCollectionPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.presenterStateStorage = 
          ImagesCollectionPresenterStateStorage(breed: breed,
                                                subbreed: subbreed)

        let interactor = ImagesCollectionInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
