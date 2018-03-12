//
//  SubbreedListSubbreedListInteractor.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 27/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import Foundation
import PromiseKit

// MARK: - SubbreedListInteractorInput
class SubbreedListInteractor: SubbreedListInteractorInput {

  weak var output: SubbreedListInteractorOutput!
  
  private let typesRemoteService = DoggoTypesRemoteService()
  private let typesLocalService = DoggoTypesLocalService()
  
  // MARK: - Private
  private func loadSubbreedsFromServerAndSaveThem(uplineBreed: Breed) -> Promise<[Subbreed]> {
    return Promise<[Subbreed]>.init(resolvers: { (fulfill, reject) in
      typesRemoteService.loadSubbreedList(breed: uplineBreed)
        .then { [weak self] (subbreeds) -> Promise<[Subbreed]> in
          guard let existingSelf = self else { throw LocalServiceError.selfIsDeallocated }
          return existingSelf.typesLocalService.save(subbreeds: subbreeds, uplineBreed: uplineBreed)
          
        }.then { (subbreeds) -> Void in
          fulfill(subbreeds)
          
        }.catch { (error) in
          reject(error)
          
      }
    })
  }

  // MARK: - Internal
  func obtainSubbreeds(breed: Breed) {
    typesLocalService.fetchSubbreeds(uplineBreed: breed)
      .recover { [weak self] (_) -> Promise<[Subbreed]> in
        guard let existingSelf = self else { throw NSError.cancelledError() }
        return existingSelf.loadSubbreedsFromServerAndSaveThem(uplineBreed: breed)
        
      }.then { [weak self] (subbreeds) -> Void in
        guard let existingSelf = self else { throw NSError.cancelledError() }
        existingSelf.output.didObtainSubbreeds(subbreeds)
        
      }.catch { [weak self] (error) in
        guard let existingSelf = self else { return }
        existingSelf.output.couldNotObtainSubbreeds(error)
    }
  }
  
}
