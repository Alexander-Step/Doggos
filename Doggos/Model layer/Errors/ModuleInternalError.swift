//
//  ModuleInternalError.swift
//  Doggos
//
//  Created by Alexander on 3/30/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

enum ModuleInternalError: String, Error {
  case castError = "Something went wrong"
  case timingError = "Please try again later"
  case notFoundError = "No data found"
  case noSubbreedsFound = "No subbreeds found for this breed, try these ones: hound, spaniel, ..."
  case logicError = "Sorry, some logic went wrong"
}
