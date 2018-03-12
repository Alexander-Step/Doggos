//
//  LocalServiceError.swift
//  Doggos
//
//  Created by Alexander on 4/23/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

enum LocalServiceError: String, Error {
  case noContext = "Context lost"
  case couldNotSaveEntity = "Could not save an object"
  case couldNotFindEntity = "Could not find an object"
  case couldNotParseEntityToPOSO = "Could not parse database entity"
  case couldNotParsePOSOToEntity = "Could not parse plain object"
  case incorrectType = "Incorrect type"
  case selfIsDeallocated = "Self is deallocated"
}
