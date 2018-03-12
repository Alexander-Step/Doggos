//
//  RightHalfScreenInteractiveTansitionHandler.swift
//  Doggos
//
//  Created by Alexander on 4/3/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

class RightHalfInteractiveTansitioner: NSObject {
  
  let transitionInteractionsController = TransitionInteractionsController()
  
}

// MARK: - UIViewControllerTransitioningDelegate
extension RightHalfInteractiveTansitioner: UIViewControllerTransitioningDelegate {
  
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return ViewsPreservingPresentationController(presentedViewController: presented,
                                                 presenting: presenting)
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return RightHalfScreenPresentAnimator()
  }
 
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return RightHalfScreenDismissAnimator()
  }
  
  func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return transitionInteractionsController.transitionHasStarted ? transitionInteractionsController : nil
  }
  
}
