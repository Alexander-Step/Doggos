//
//  RightHalfScreenPresentAnimator.swift
//  Doggos
//
//  Created by Alexander on 4/3/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

let standartAnimationDurationSeconds = 0.3

class RightHalfScreenPresentAnimator: NSObject {
  
}

// MARK: - UIViewControllerAnimatedTransitioning
extension RightHalfScreenPresentAnimator: UIViewControllerAnimatedTransitioning {
  
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return standartAnimationDurationSeconds
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromViewController = transitionContext.viewController(forKey: .from),
          let toViewController = transitionContext.viewController(forKey: .to) else {
        return
    }
    let toViewWidth = (UIScreen.main.bounds.width/2).rounded()
    let startFrame = CGRect(x: UIScreen.main.bounds.width.rounded(),
                            y: 0,
                            width: toViewWidth,
                            height: UIScreen.main.bounds.height.rounded())
    let endFrame = CGRect(x: (UIScreen.main.bounds.width - toViewWidth).rounded(),
                          y: 0,
                          width: toViewWidth,
                          height: UIScreen.main.bounds.height.rounded())
    let containerView = transitionContext.containerView
    containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
    toViewController.view.frame = startFrame
    UIView.animate(withDuration: standartAnimationDurationSeconds,
                   delay: 0,
                   options: [UIViewAnimationOptions.curveEaseOut],
                   animations: {
        toViewController.view.frame = endFrame
      }) { (_) -> Void in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      }
  }
  
}
