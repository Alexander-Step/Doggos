//
//  SubbreedListSubbreedListConfigurator.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 27/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import UIKit

class SubbreedListModuleConfigurator {

  func configureModuleForViewInput<UIViewController>(viewInput: UIViewController,
                                                     uplineBreed: Breed) {

        if let viewController = viewInput as? DoggoTypeListViewController {
            configure(viewController: viewController,
                      uplineBreed: uplineBreed)
        }
    }

    private func configure(viewController: DoggoTypeListViewController,
                           uplineBreed: Breed) {

        let router = SubbreedListRouter()
        router.transitionHandler = viewController as DoggosViperModuleTransitionHandler

        let presenter = SubbreedListPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.presenterStateStorage = 
          SubbreedListPresenterStateStorage(uplineBreed: uplineBreed)

        let interactor = SubbreedListInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
