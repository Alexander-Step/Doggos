//
//  TypesFlowSelectionViewController.swift
//  Doggos
//
//  Created by Alexander on 4/2/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

class TypesFlowSelectionViewController: UIViewController {
  
  weak var output: TypesFlowSelectionViewOutput?
  
  let rightHalfScreenTransitioner = RightHalfInteractiveTansitioner()
  
  @IBOutlet weak private var subbreedsSwitch: UISwitch?
  
  // MARK: - Lifecycle
  init() {
    let typesFlowSelectionViewXIBName = "TypesFlowSelectionView"
    super.init(nibName: typesFlowSelectionViewXIBName, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: - IBActions
  @IBAction private func subbreedsSwitchAction(_ sender: UISwitch) {
    if sender.isOn {
      output?.didSelectIncludeSubbreeds()
    } else {
      output?.didSelectExcludeSubbreeds()
    }
  }
  
  @IBAction private func closeButtonAction(_ sender: UIButton) {
    output?.didTapCloseButton()
  }
  
  @IBAction private func panGestureAction(_ sender: UIPanGestureRecognizer) {
    let cancelDecimalTreshold: CGFloat = 0.15
    let gestureTranslation = sender.translation(in: view)
    let horizontalDecimalMovement = gestureTranslation.x / view.bounds.width
    let rightHeadedDecimalMovement = fmax(horizontalDecimalMovement, 0.0)
    let rightHeadedDecimalMovementNormalized = fmin(rightHeadedDecimalMovement, 1.0)
    
    switch sender.state {
    case .began:
      rightHalfScreenTransitioner.transitionInteractionsController.transitionHasStarted = true
      dismiss(animated: true, completion: nil)
    case .changed:
      rightHalfScreenTransitioner.transitionInteractionsController.transitionShouldFinish =
        rightHeadedDecimalMovementNormalized > cancelDecimalTreshold
      rightHalfScreenTransitioner.transitionInteractionsController.update(rightHeadedDecimalMovementNormalized)
    case .cancelled:
      rightHalfScreenTransitioner.transitionInteractionsController.transitionHasStarted = false
      rightHalfScreenTransitioner.transitionInteractionsController.cancel()
    case .ended:
      rightHalfScreenTransitioner.transitionInteractionsController.transitionHasStarted = false
      rightHalfScreenTransitioner.transitionInteractionsController.transitionShouldFinish
        ? rightHalfScreenTransitioner.transitionInteractionsController.finish()
        : rightHalfScreenTransitioner.transitionInteractionsController.cancel()
    default:
      break
    }
  }

}

// MARK: - Internal functions
extension TypesFlowSelectionViewController {
  
  func configureTransitioningDelegate() {
    modalPresentationStyle = .custom
    transitioningDelegate = rightHalfScreenTransitioner
  }
  
  func fulfillViewInitializing() {
    _ = view
  }
  
  func configureViewState(includeSubbreedsSetting: Bool) {
    subbreedsSwitch?.setOn(includeSubbreedsSetting, animated: false)
  }
  
}
