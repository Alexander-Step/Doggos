//
//  ImagesCollectionImagesCollectionRouter.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 06/04/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//
import UIKit

class ImagesCollectionRouter {
	weak var transitionHandler: DoggosViperModuleTransitionHandler!
}

// MARK: - ImagesCollectionRouterInput
extension ImagesCollectionRouter: ImagesCollectionRouterInput {
  
  func openImageDetailsModule(image: UIImage, viewContainingImage: UIView) {
    let imageDetailsViewController = ImageDetailsViewController.createViewController(viewWithImageToTransitFrom: viewContainingImage)
    let imageDetailsConfigurator = ImageDetailsModuleConfigurator()
    imageDetailsConfigurator.configureModuleForViewInput(viewInput: imageDetailsViewController,
                                                         image: image)
    transitionHandler.showModallyNewViewControllerThatUsesCustomTransitioningDelegate(imageDetailsViewController, animated: true)
  }

}
