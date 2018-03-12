//
//  Breed.swift
//  Doggos
//
//  Created by Alexander on 3/16/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

// MARK: - Protocol
protocol Breed: DoggoType {
  var name: String { get }
  var subbreeds: [Subbreed]? { get }
  var images: [ImageLinkContainer]? { get }
  
  init(name: String, subbreeds: [Subbreed]?, images: [ImageLinkContainer]?)
  init(breedEntity: BreedEntity?) throws
}

// MARK: - Storage
struct BreedStorage: Breed {
  var name: String
  var subbreeds: [Subbreed]?
  var images: [ImageLinkContainer]?

  init(name: String, subbreeds: [Subbreed]? = nil, images: [ImageLinkContainer]? = nil) {
    self.name = name
    self.subbreeds = subbreeds
    self.images = images
  }
  
  init(breedEntity: BreedEntity?) throws {
    guard let existingBreedEntity = breedEntity,
          let existingName = existingBreedEntity.name
      else { throw LocalServiceError.couldNotParseEntityToPOSO }
    name = existingName
    breedEntity?.images?.forEach({ (imageContainerEntityAsAny) in
      if let imageContainerEntity = imageContainerEntityAsAny as? ImageLinkContainerEntity,
          let link = imageContainerEntity.link {
        let imageContainer = ImageLinkContainer(link: link)
        images?.append(imageContainer)
      }
    })
    breedEntity?.subbreeds?.forEach({ (subbreedAsAny) in
      if let subbreedEntity = subbreedAsAny as? SubbreedEntity {
        do {
          let subbreed = try SubbreedStorage(subbreedEntity: subbreedEntity) as Subbreed
          subbreeds?.append(subbreed)
        } catch {
          print("Could not create SubbreedStorage fro entity: \(error)")
        }
      }
    })
  }
}

// MARK: - Parsing methods
extension BreedStorage {
  static func breeds(from doggosTypesList: DoggosTypesList) -> [Breed] {
    var breeds = [BreedStorage]()
    doggosTypesList.types.forEach({ (breedName) in
      let breed = BreedStorage(name: breedName)
      breeds.append(breed)
    })
    return breeds as [Breed]
  }
}
