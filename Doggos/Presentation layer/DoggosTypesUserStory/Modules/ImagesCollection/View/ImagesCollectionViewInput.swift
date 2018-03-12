//
//  ImagesCollectionImagesCollectionViewInput.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 06/04/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

protocol ImagesCollectionViewInput: class {

  /**
      @author Alexander_Stepanishin
      Setup initial state of the view
  */

  func configure(with imageLinks: [ImageLinkContainer])
  func showError(_ error: Error?)
}
