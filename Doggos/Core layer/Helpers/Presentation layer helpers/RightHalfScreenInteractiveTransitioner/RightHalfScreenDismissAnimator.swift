//
//  RightHalfScreenDismissAnimationController.swift
//  Doggos
//
//  Created by Alexander on 4/3/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

class RightHalfScreenDismissAnimator: NSObject {
  
}

// MARK: - UIViewControllerAnimatedTransitioning
extension RightHalfScreenDismissAnimator: UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return standartAnimationDurationSeconds
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromViewController = transitionContext.viewController(forKey: .from) else {
        return
    }
    let endFrame = CGRect(x: UIScreen.main.bounds.width.rounded(),
                          y: 0,
                          width: fromViewController.view.bounds.width.rounded(),
                          height: fromViewController.view.bounds.height.rounded())
    UIView.animate(withDuration: standartAnimationDurationSeconds,
                   delay: 0,
                   options: [UIViewAnimationOptions.curveEaseOut],
                   animations: {
      fromViewController.view.frame = endFrame
    }) { (_) in
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }
  
}
