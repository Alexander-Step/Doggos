//
//  ImageLinkContainer.swift
//  Doggos
//
//  Created by Alexander on 4/20/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

struct ImageLinkContainer {
  
  let link: String
  
}

extension ImageLinkContainer {
  
  init(imageLinkContainerEntity: ImageLinkContainerEntity) throws {
    if let linkFromEntity = imageLinkContainerEntity.link {
      link = linkFromEntity
    } else {
      throw LocalServiceError.couldNotParseEntityToPOSO
    }
  }
  
}
