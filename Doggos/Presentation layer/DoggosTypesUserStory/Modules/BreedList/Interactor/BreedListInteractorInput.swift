//
//  BreedListBreedListInteractorInput.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 14/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import PromiseKit

protocol BreedListInteractorInput {
  
  func obtainBreeds()
  func obtainSubbreedsForTransitionValidation(breed: Breed)

}
