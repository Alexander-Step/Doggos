//
//  ViewsPreservingPresentationController.swift
//  Doggos
//
//  Created by Alexander on 4/3/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import UIKit

class ViewsPreservingPresentationController: UIPresentationController {
  
  override var shouldRemovePresentersView: Bool {
    return false
  }
  
}
