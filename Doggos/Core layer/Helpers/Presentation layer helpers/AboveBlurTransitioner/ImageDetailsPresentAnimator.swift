//
//  ImageDetailsPresentAnimator.swift
//  Doggos
//
//  Created by Alexander on 5/31/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

let imageShowAnimationDampingRatio: CGFloat = 0.8
let delayFactorForFaidingInTheBackButton: CGFloat = 0.5
let backButtonPresentingStartAlpha: CGFloat = 0
let backButtonPresentingEndAlpha: CGFloat = 1

class ImageDetailsPresentAnimator: NSObject {
  
  var viewToPresentImageFrom: UIView
  
  // MARK: - Lifecycle
  init(view: UIView) {
    viewToPresentImageFrom = view
  }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension ImageDetailsPresentAnimator: UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return standartAnimationDurationSeconds
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromViewController = transitionContext.viewController(forKey: .from),
      let toViewController = transitionContext.viewController(forKey: .to),
      let imageDetailsViewController = toViewController as? ImageDetailsViewController else {
        return
    }
    guard let centralImageView = imageDetailsViewController.centralImageView else {
      let containerView = transitionContext.containerView
      containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      return
    }
    
    // Views hierarchy
    imageDetailsViewController.view.frame = fromViewController.view.frame
    imageDetailsViewController.view.layoutIfNeeded()
    let containerView = transitionContext.containerView
    containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
    
    // Blur and image
    let centralImageStartFrame = viewToPresentImageFrom.convert(viewToPresentImageFrom.frame,
                                                                to: imageDetailsViewController.view)
    let centralImageEndFrame = centralImageView.frame
    centralImageView.frame = centralImageStartFrame
    let viewsAnimator = UIViewPropertyAnimator(duration: standartAnimationDurationSeconds * 2,
                                               dampingRatio: imageShowAnimationDampingRatio) {
      centralImageView.frame = centralImageEndFrame
      imageDetailsViewController.addBlurEffect()
    }
    viewsAnimator.addAnimations({
      centralImageView.transform = centralImageView.transform.rotated(by: CGFloat(Double.pi))
      centralImageView.transform = centralImageView.transform.rotated(by: CGFloat(Double.pi))
    }, delayFactor: 0.1)
    
    // Back button with delay
    imageDetailsViewController.backButton?.alpha = backButtonPresentingStartAlpha
    viewsAnimator.addAnimations({
      imageDetailsViewController.backButton?.alpha = backButtonPresentingEndAlpha
    }, delayFactor: delayFactorForFaidingInTheBackButton)
    
    // Execute animation with completion
    viewsAnimator.addCompletion { (_) in
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
    viewsAnimator.startAnimation()
  }
  
}

// MARK: - Private
extension ImageDetailsPresentAnimator {
  
}
