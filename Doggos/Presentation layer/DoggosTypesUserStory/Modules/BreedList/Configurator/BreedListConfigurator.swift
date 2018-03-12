//
//  BreedListBreedListConfigurator.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 14/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import UIKit

class BreedListModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? DoggoTypeListViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: DoggoTypeListViewController) {

        let router = BreedListRouter()
        router.transitionHandler = viewController as DoggosViperModuleTransitionHandler

        let presenter = BreedListPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.presenterStateStorage = BreedListPresenterStateStorage()

        let interactor = BreedListInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
