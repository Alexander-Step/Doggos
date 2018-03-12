//
//  BreedListBreedListInteractor.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 14/03/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import Foundation
import PromiseKit

// MARK: - BreedListInteractorInput
class BreedListInteractor: BreedListInteractorInput {

  weak var output: BreedListInteractorOutput!
  
  private let typesRemoteService = DoggoTypesRemoteService()
  private let typesLocalService = DoggoTypesLocalService()
  
  // MARK: - Private
  private func loadBreedsFromServerAndSaveThem() -> Promise<[Breed]> {
    return Promise<[Breed]>.init(resolvers: { (fulfill, reject) in
      typesRemoteService.loadBreedList()
        .then { [weak self] (breeds) -> Promise<[Breed]> in
          guard let existingSelf = self else { throw LocalServiceError.selfIsDeallocated }
          return existingSelf.typesLocalService.save(breeds: breeds)
          
        }.then { (breeds) -> Void in
          fulfill(breeds)
          
        }.catch { (error) in
          reject(error)
          
      }
    })
  }
  
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
  func obtainBreeds() {
    typesLocalService.fetchBreeds()
      .recover { [weak self] (_) -> Promise<[Breed]> in
        guard let existingSelf = self else { throw NSError.cancelledError() }
        return existingSelf.loadBreedsFromServerAndSaveThem()
        
      }.then { [weak self] (breeds) -> Void in
        guard let existingSelf = self else { throw NSError.cancelledError() }
        existingSelf.output.didObtainBreeds(breeds)
        
      }.catch { [weak self] (error) in
        guard let existingSelf = self else { return }
        existingSelf.output.couldNotObtainBreeds(error)
    }
  }

  func obtainSubbreedsForTransitionValidation(breed: Breed) {
    typesLocalService.fetchSubbreeds(uplineBreed: breed)
      .recover { [weak self] (_) -> Promise<[Subbreed]> in
        guard let existingSelf = self else { throw NSError.cancelledError() }
        return existingSelf.loadSubbreedsFromServerAndSaveThem(uplineBreed: breed)
        
      }.then { [weak self] (subbreeds) -> Void in
        guard let existingSelf = self else { throw NSError.cancelledError() }
        existingSelf.output.didObtainSubbreedsForTransitionValidation(subbreeds: subbreeds,
                                                                      uplineBreed: breed)
        
      }.catch { [weak self] (error) in
        guard let existingSelf = self else { return }
        existingSelf.output.couldNotObtainSubbreedsForTransitionValidation(error)
    }
  }

}
