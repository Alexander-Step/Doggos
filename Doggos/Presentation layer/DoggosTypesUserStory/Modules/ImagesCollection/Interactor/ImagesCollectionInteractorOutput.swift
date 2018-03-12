//
//  ImagesCollectionImagesCollectionInteractorOutput.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 06/04/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import UIKit

protocol ImagesCollectionInteractorOutput: class {
  
  func didObtainImageLinks(_ imageLinks: [ImageLinkContainer])
  func couldNotObtainImageLinks(_ error: Error)
  
}
