//
//  ImageDetailsDismissAnimator.swift
//  Doggos
//
//  Created by Alexander on 5/31/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

let delayFactorForInvalidatingBlur: CGFloat = 0.4

class ImageDetailsDismissAnimator: NSObject {
  var viewFromWhichImageWasPresented: UIView
  
  // MARK: - Lifecycle
  init(view: UIView) {
    viewFromWhichImageWasPresented = view
  }
  
}

// MARK: - UIViewControllerAnimatedTransitioning
extension ImageDetailsDismissAnimator: UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return standartAnimationDurationSeconds
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromViewController = transitionContext.viewController(forKey: .from),
          let imageDetailsViewController = fromViewController as? ImageDetailsViewController else {
      return
    }
    guard let centralImageView = imageDetailsViewController.centralImageView else {
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      return
    }
    
    // Back button and image
    let viewsAnimator = UIViewPropertyAnimator(duration: standartAnimationDurationSeconds,
                                               dampingRatio: imageShowAnimationDampingRatio) {
        imageDetailsViewController.backButton?.alpha = backButtonPresentingStartAlpha
        centralImageView.frame =
          self.viewFromWhichImageWasPresented.convert(self.viewFromWhichImageWasPresented.frame,
                                                      to: imageDetailsViewController.view)
    }
    
    // Blur with delay
    viewsAnimator.addAnimations({
      imageDetailsViewController.removeBlurEffect()
    }, delayFactor: delayFactorForInvalidatingBlur)
    
    // Executing animation with completion
    viewsAnimator.addCompletion { (_) in
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
    viewsAnimator.startAnimation()
    
  }
  
}
