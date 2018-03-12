//
//  DoggoTypesLocalService.swift
//  Doggos
//
//  Created by Alexander on 4/24/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import PromiseKit

class DoggoTypesLocalService: PersistentSaverAccesser {
  
  func fetchBreeds() -> Promise<[Breed]> {
    return Promise<[Breed]>.init(resolvers: { (fulfill, reject) in
      var resultBreeds = [Breed]()
      let fetchRequestForBreed = BreedEntity.fetchRequestForBreed()
      let breedEntities = try obtainViewContext().fetch(fetchRequestForBreed)
      try breedEntities.forEach({ (breedEntity) in
        let breed = try BreedStorage(breedEntity: breedEntity) as Breed
        resultBreeds.append(breed)
      })
      if !resultBreeds.isEmpty {
        fulfill(resultBreeds)
      } else {
        reject(LocalServiceError.couldNotFindEntity)
      }
    })
  }
  
  func fetchSubbreeds(uplineBreed: Breed) -> Promise<[Subbreed]> {
    return Promise<[Subbreed]>.init(resolvers: { (fulfill, reject) in
      var resultSubbreeds = [Subbreed]()
      let fetchRequestForBreed = BreedEntity.fetchRequestForBreed(name: uplineBreed.name)
      let breedEntityArray = try obtainViewContext().fetch(fetchRequestForBreed)
      guard let breedEntity = breedEntityArray.first
        else { throw LocalServiceError.couldNotFindEntity }
      try breedEntity.subbreeds?.forEach({ (subbreedEntityAsAny) in
        if let subbreedEntity = subbreedEntityAsAny as? SubbreedEntity {
          let subbreed = try SubbreedStorage(subbreedEntity: subbreedEntity)
          resultSubbreeds.append(subbreed)
        } else {
          throw LocalServiceError.incorrectType
        }
      })
      if !resultSubbreeds.isEmpty {
        fulfill(resultSubbreeds)
      } else {
        reject(LocalServiceError.couldNotFindEntity)
      }
    })
  }
  
}
