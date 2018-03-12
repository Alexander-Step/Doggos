//
//  ImageDetailsTransitioner.swift
//  Doggos
//
//  Created by Alexander on 5/31/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

class ImageDetailsTransitioner: NSObject {
  var viewToPresentImageFrom: UIView
  
  // MARK: - Lifecycle
  init(viewWithImage: UIView) {
    viewToPresentImageFrom = viewWithImage
  }
}

// MARK: - UIViewControllerTransitioningDelegate
extension ImageDetailsTransitioner: UIViewControllerTransitioningDelegate {
  
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return ViewsPreservingPresentationController(presentedViewController: presented,
                                                 presenting: presenting)
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return ImageDetailsPresentAnimator(view: viewToPresentImageFrom)
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return ImageDetailsDismissAnimator(view: viewToPresentImageFrom)
  }
  
}
