//
//  BreedListBreedListInteractorOutput.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 14/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import Foundation

protocol BreedListInteractorOutput: class {
  
  func didObtainBreeds(_ breeds: [Breed])
  func didObtainSubbreedsForTransitionValidation(subbreeds: [Subbreed], uplineBreed: Breed)
  func couldNotObtainSubbreedsForTransitionValidation(_ error: Error)
  func couldNotObtainBreeds(_ error: Error?)
}
