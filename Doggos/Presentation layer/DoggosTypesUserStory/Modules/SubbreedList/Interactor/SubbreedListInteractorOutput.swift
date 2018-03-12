//
//  SubbreedListSubbreedListInteractorOutput.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 27/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import Foundation

protocol SubbreedListInteractorOutput: class {

  func didObtainSubbreeds(_ subbreeds: [Subbreed])
  func couldNotObtainSubbreeds(_ error: Error?)
  
}
