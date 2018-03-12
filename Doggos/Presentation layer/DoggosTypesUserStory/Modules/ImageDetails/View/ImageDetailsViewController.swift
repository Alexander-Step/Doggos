//
//  ImageDetailsImageDetailsViewController.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 30/05/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import UIKit

class ImageDetailsViewController: UIViewController {
  
  var aboveBlurTransitioner: ImageDetailsTransitioner
  
  var output: ImageDetailsViewOutput!

  @IBOutlet weak var visualEffectView: UIVisualEffectView?
  @IBOutlet weak var centralImageView: UIImageView?
  @IBOutlet weak var backButton: UIButton?
  var image: UIImage?
  
  // MARK: Life cycle
  init(viewWithImageToTransitFrom: UIView) {
    aboveBlurTransitioner = ImageDetailsTransitioner(viewWithImage: viewWithImageToTransitFrom)
    let imageDetailsViewXIBName = "ImageDetailsView"
    super.init(nibName: imageDetailsViewXIBName, bundle: nil)
    configureTransitioningDelegate()
  }
  
  required init?(coder aDecoder: NSCoder) {
    return nil
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initiallySetupVisualEffectView()
    output.viewIsReady()
  }
  
  // MARK: - Private
  private func initiallySetupVisualEffectView() {
    visualEffectView?.effect = nil
  }
  
  @IBAction func backButtonAction(_ sender: UIButton) {
    output.backButtonTapped()
  }
  
}

// MARK: - Internal functions
extension ImageDetailsViewController {
  
  func configureTransitioningDelegate() {
    modalPresentationStyle = .custom
    transitioningDelegate = aboveBlurTransitioner
  }
    
  func addBlurEffect() {
    visualEffectView?.effect = UIBlurEffect(style: .light)
  }
  
  func removeBlurEffect() {
    visualEffectView?.effect = nil
  }
  
}

// MARK: - ImageDetailsViewInput
extension ImageDetailsViewController: ImageDetailsViewInput {

  func setupInitialState() {
  }
  
  func configure(with image: UIImage) {
    centralImageView?.image = image
  }
  
}

extension ImageDetailsViewController {
  
  static func createViewController(viewWithImageToTransitFrom: UIView) -> UIViewController {
    return ImageDetailsViewController.init(viewWithImageToTransitFrom: viewWithImageToTransitFrom)
  }
  
}
