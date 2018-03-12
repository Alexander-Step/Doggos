//
//  DoggosUIImagesConstructor.swift
//  Doggos
//
//  Created by Alexander on 6/26/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

protocol DoggosUIImagesConstructTasksExecuter {
}

extension DoggosUIImagesConstructTasksExecuter {
  
  static func doggoTypeCellBackgroundImageThrowing() throws -> UIImage {
    if let image = UIImage(named: "img_cell_gradient") {
      return image
    } else {
      throw ModuleInternalError.notFoundError
    }
  }
  
  static func navBarBackgroundImageThrowing() throws -> UIImage {
    if let image = UIImage(named: "img_nav_bar_gradient") {
      return image
    } else {
      throw ModuleInternalError.notFoundError
    }
  }
  
  static func crossImageThrowing() throws -> UIImage {
    if let image = UIImage(named: "ic_cross") {
      return image
    } else {
      throw ModuleInternalError.notFoundError
    }
  }
  
  static func selectFlowBackgroundGradientThrowing() throws -> UIImage {
    if let image = UIImage(named: "img_select_flow_gradient") {
      return image
    } else {
      throw ModuleInternalError.notFoundError
    }
  }
  
  static func doggoFaceThrowing() throws -> UIImage {
    if let image = UIImage(named: "img_doggo_face") {
      return image
    } else {
      throw ModuleInternalError.notFoundError
    }
  }
  
}
