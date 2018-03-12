//
//  ImagesLinksList.swift
//  Doggos
//
//  Created by Alexander on 3/20/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

struct ImagesLinksList: Codable {
  var status: String?
  var imagesLinks: [String]?

  enum CodingKeys: String, CodingKey {
    case status = "status"
    case imagesLinks = "message"
  }
}
