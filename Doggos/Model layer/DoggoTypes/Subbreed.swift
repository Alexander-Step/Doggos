//
//  SubbreedStorage.swift
//  Doggos
//
//  Created by Alexander on 3/19/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

// MARK: - Protocol
protocol Subbreed: DoggoType {
  var name: String { get }
  var images: [ImageLinkContainer]? { get }
  
  init(name: String, imagesLinks: [ImageLinkContainer]?)
  init(subbreedEntity: SubbreedEntity?) throws
}

// MARK: - Storage
struct SubbreedStorage: Subbreed {
  var name: String
  var images: [ImageLinkContainer]?

  init(name: String, imagesLinks: [ImageLinkContainer]? = nil) {
    self.name = name
    self.images = imagesLinks
  }
  
  init(subbreedEntity: SubbreedEntity?) throws {
    guard let existingSubbreedEntity = subbreedEntity,
          let existingName = existingSubbreedEntity.name
      else { throw LocalServiceError.couldNotParseEntityToPOSO }
    self.name = existingName
    subbreedEntity?.images?.forEach({ (imageContainerEntityAsAny) in
      if let imageContainerEntity = imageContainerEntityAsAny as? ImageLinkContainerEntity,
        let link = imageContainerEntity.link {
        let imageContainer = ImageLinkContainer(link: link)
        images?.append(imageContainer)
      }
    })
  }
}

// MARK: - Parsing methods
extension SubbreedStorage {
  static func subbreeds(from doggosTypesList: DoggosTypesList) -> [Subbreed] {
    var subbreeds = [SubbreedStorage]()
    doggosTypesList.types.forEach({ (breedName) in
      let subbreed = SubbreedStorage(name: breedName)
      subbreeds.append(subbreed)
    })
    return subbreeds as [Subbreed]
  }
}
