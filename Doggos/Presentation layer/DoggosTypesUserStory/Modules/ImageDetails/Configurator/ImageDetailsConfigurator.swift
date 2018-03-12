//
//  ImageDetailsImageDetailsConfigurator.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 30/05/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import UIKit

class ImageDetailsModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController,
                                                       image: UIImage) {

        if let viewController = viewInput as? ImageDetailsViewController {
            configure(viewController: viewController,
                      image: image)
        }
    }

    private func configure(viewController: ImageDetailsViewController,
                           image: UIImage) {

        let router = ImageDetailsRouter()
        router.transitionHandler = viewController as DoggosViperModuleTransitionHandler

        let presenter = ImageDetailsPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.presenterStateStorage = 
          ImageDetailsPresenterStateStorage(image: image)

        let interactor = ImageDetailsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
