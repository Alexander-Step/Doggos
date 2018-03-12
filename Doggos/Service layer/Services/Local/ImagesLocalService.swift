//
//  ImagesLocalService.swift
//  Doggos
//
//  Created by Alexander on 4/24/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import PromiseKit

class ImagesLocalService: PersistentSaverAccesser {
  
  func fetchImageLinkContainers(breed: Breed) -> Promise<[ImageLinkContainer]> {
    return Promise<[ImageLinkContainer]>.init(resolvers: { (fulfill, reject) in
      var resultLinkContainers = [ImageLinkContainer]()
      let fetchRequestForBreed = BreedEntity.fetchRequestForBreed(name: breed.name)
      let viewContext = obtainViewContext()
      let breedEntityArray = try viewContext.fetch(fetchRequestForBreed)
      try breedEntityArray.first?.images?.forEach({ (linkContainerAsAny) in
        if let linkContainerEntity = linkContainerAsAny as? ImageLinkContainerEntity {
          let imageLinkContainer = try ImageLinkContainer(imageLinkContainerEntity: linkContainerEntity)
          resultLinkContainers.append(imageLinkContainer)
        } else {
          reject(LocalServiceError.incorrectType)
        }
      })
      if !resultLinkContainers.isEmpty {
        fulfill(resultLinkContainers)
      } else {
        reject(LocalServiceError.couldNotFindEntity)
      }
      
    })
  }

  func fetchImageLinkContainers(subbreed: Subbreed) -> Promise<[ImageLinkContainer]> {
    return Promise<[ImageLinkContainer]>.init(resolvers: { (fulfill, reject) in
      var resultLinkContainers = [ImageLinkContainer]()
      let fetchRequestForBreed = SubbreedEntity.fetchRequestForSubbreed(name: subbreed.name)
      let viewContext = obtainViewContext()
      let subbreedEntityArray = try viewContext.fetch(fetchRequestForBreed)
      try subbreedEntityArray.first?.images?.forEach({ (linkContainerAsAny) in
        if let linkContainerEntity = linkContainerAsAny as? ImageLinkContainerEntity {
          let imageLinkContainer = try ImageLinkContainer(imageLinkContainerEntity: linkContainerEntity)
          resultLinkContainers.append(imageLinkContainer)
        } else {
          reject(LocalServiceError.incorrectType)
        }
      })
      if !resultLinkContainers.isEmpty {
        fulfill(resultLinkContainers)
      } else {
        reject(LocalServiceError.couldNotFindEntity)
      }
      
    })
  }
  
}
