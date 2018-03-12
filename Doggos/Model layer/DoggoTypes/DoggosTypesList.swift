//
//  DoggosTypesList.swift
//  Doggos
//
//  Created by Alexander on 3/16/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

struct DoggosTypesList: Codable {
  var status: String?
  var types: [String]

  enum CodingKeys: String, CodingKey {
    case status = "status"
    case types = "message"
  }
}
