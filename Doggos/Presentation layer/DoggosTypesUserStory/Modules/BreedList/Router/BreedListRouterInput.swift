//
//  BreedListBreedListRouterInput.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 14/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import Foundation

protocol BreedListRouterInput {
  
  func openSubbreedListModule(uplineBreed: Breed)
  func openImagesModule(breed: Breed)
  
}
