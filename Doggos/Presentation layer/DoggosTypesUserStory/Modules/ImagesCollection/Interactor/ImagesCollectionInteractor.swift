//
//  ImagesCollectionImagesCollectionInteractor.swift
//  Doggos
//
//  Created by Alexander_Stepanishin on 06/04/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import PromiseKit

// MARK: - ImagesCollectionInteractorInput
class ImagesCollectionInteractor: ImagesCollectionInteractorInput {

  weak var output: ImagesCollectionInteractorOutput!
  
  private let imagesRemoteService = ImagesRemoteService()
  private let imagesLocalService = ImagesLocalService()
  
  // MARK: - Private
  private func obtainBreedImageLinks(breed: Breed) {
    imagesLocalService.fetchImageLinkContainers(breed: breed)
      .recover { [weak self] (_) -> Promise<[ImageLinkContainer]> in
        guard let existingSelf = self else { throw NSError.cancelledError() }
        return existingSelf.loadBreedImageLinksFromServerAndSaveThem(breed: breed)
        
      }.then { [weak self] (linkContainers) -> Void in
        guard let existingSelf = self else { throw NSError.cancelledError() }
        existingSelf.output.didObtainImageLinks(linkContainers)
        
      }.catch { [weak self] (error) in
        guard let existingSelf = self else { return }
        existingSelf.output.couldNotObtainImageLinks(error)
    }
  }
  
  private func loadBreedImageLinksFromServerAndSaveThem(breed: Breed) -> Promise<[ImageLinkContainer]> {
    return Promise<[ImageLinkContainer]>.init(resolvers: { (fulfill, reject) in
      imagesRemoteService.loadBreedImagesLinks(breed)
        .then { [weak self] (linkContainers) -> Promise<[ImageLinkContainer]> in
          guard let existingSelf = self else { throw LocalServiceError.selfIsDeallocated }
          return existingSelf.imagesLocalService.save(linkContainers: linkContainers, uplineBreed: breed)
          
        }.then { (savedLinkContainers) -> Void in
          fulfill(savedLinkContainers)
          
        }.catch { (error) in
          reject(error)
      }
    })
  }
  
  private func obtainSubbreedImageLinks(breed: Breed, subbreed: Subbreed) {
    imagesLocalService.fetchImageLinkContainers(subbreed: subbreed)
      .recover { [weak self] (_) -> Promise<[ImageLinkContainer]> in
        guard let existingSelf = self else { throw NSError.cancelledError() }
        return existingSelf.loadSubbreedImagesLinksFromServerAndSaveThem(breed: breed, subbreed: subbreed)
        
      }.then { [weak self] (linkContainers) -> Void in
        guard let existingSelf = self else { throw NSError.cancelledError() }
        existingSelf.output.didObtainImageLinks(linkContainers)
        
      }.catch { [weak self] (error) in
        guard let existingSelf = self else { return }
        existingSelf.output.couldNotObtainImageLinks(error)
    }
  }
  
  private func loadSubbreedImagesLinksFromServerAndSaveThem(breed: Breed, subbreed: Subbreed) -> Promise<[ImageLinkContainer]> {
    return Promise<[ImageLinkContainer]>.init(resolvers: { (fulfill, reject) in
      imagesRemoteService.loadSubbreedImagesLinks(breed: breed, subbreed: subbreed)
        .then { [weak self] (linkContainers) -> Promise<[ImageLinkContainer]> in
          guard let existingSelf = self else { throw LocalServiceError.selfIsDeallocated }
          return existingSelf.imagesLocalService.save(linkContainers: linkContainers, uplineSubbreed: subbreed)
          
        }.then { (savedLinkContainers) -> Void in
          fulfill(savedLinkContainers)
          
        }.catch { (error) in
          reject(error)
      }
    })
  }
  
  // MARK: - Internal
  func obtainImageLinks(breed: Breed, subbreed: Subbreed?) {
    if subbreed == nil {
      obtainBreedImageLinks(breed: breed)
      
    } else if let existingSubbreed = subbreed {
      obtainSubbreedImageLinks(breed: breed, subbreed: existingSubbreed)
      
    } else {
      output.couldNotObtainImageLinks(ModuleInternalError.castError)
    }
  }

}
