//
//  UIImage+DoggosTheme.swift
//  Doggos
//
//  Created by Alexander on 6/18/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

extension UIImage: DoggosUIImagesConstructTasksExecuter {
  
  // MARK: - Doggo type cell background
  static func doggoTypeCellBackgroundImage() -> UIImage {
    return try! UIImage.doggoTypeCellBackgroundImageThrowing()
  }
  
  // MARK: - Navigation bar background
  static func navBarBackgroundImage() -> UIImage {
    return try! UIImage.navBarBackgroundImageThrowing()
  }
  
  // MARK: - Navigation bar background
  static func crossImage() -> UIImage {
    return try! UIImage.crossImageThrowing()
  }
  
  // MARK: - Select flow screen backgroune
  static func selectFlowBackgroundGradient() -> UIImage {
    return try! UIImage.selectFlowBackgroundGradientThrowing()
  }
  
  // MARK: - Doggo face
  static func doggoFace() -> UIImage {
    return try! UIImage.doggoFaceThrowing()
  }
  
}
