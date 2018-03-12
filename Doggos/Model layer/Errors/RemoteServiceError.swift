//
//  RemoteServiceError.swift
//  Doggos
//
//  Created by Alexander on 3/20/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

enum RemoteServiceError: String, Error {
  case networkOffline = "Network offline"
  case noData = "Sorry, no data on this one"
}
