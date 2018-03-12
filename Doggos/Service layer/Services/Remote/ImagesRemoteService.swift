//
//  ImagesRemoteService.swift
//  Doggos
//
//  Created by Alexander on 3/19/18.
//  Copyright © 2018 None. All rights reserved.
//

import PromiseKit

class ImagesRemoteService {
  private let provider: DoggosMoyaProvider<DoggosAPI>
  
  // MARK: - Lifecycle
  init(_ newProvider: DoggosMoyaProvider<DoggosAPI>) {
    provider = newProvider
  }
  
  convenience init() {
    self.init(DoggosMoyaProvider<DoggosAPI>())
  }

  // MARK: - Internal
  func loadBreedImagesLinks(_ breed: Breed) -> Promise<[ImageLinkContainer]> {
    return Promise<[ImageLinkContainer]>(resolvers: { (fulfill, reject) in
      provider.request(.loadImagesByBreed(breed: breed.name),
                       callbackQueue: DispatchQueue.global(qos: .default),
                       completion: { (moyaResult) in
                        do {
                          let dematerializedResult = try moyaResult.dematerialize()
                          let filteredResult = try dematerializedResult.filterSuccessfulStatusCodes()
                          let imagesLinksList = try filteredResult.map(ImagesLinksList.self)
                          if let imagesLinks = imagesLinksList.imagesLinks {
                            let imageLinkContainers = imagesLinks.map({ (link) -> ImageLinkContainer in
                              ImageLinkContainer(link: link)
                            })
                            fulfill(imageLinkContainers)
                          } else {
                            throw RemoteServiceError.noData
                          }
                        } catch {
                          reject(error)
                        }
      })
    })
  }
  
  func loadSubbreedImagesLinks(breed: Breed, subbreed: Subbreed) -> Promise<[ImageLinkContainer]> {
    return Promise<[ImageLinkContainer]>(resolvers: { (fulfill, reject) in
      provider.request(.loadImagesBySubbreed(breed: breed.name, subbreed: subbreed.name),
                       callbackQueue: DispatchQueue.global(qos: .default),
                       completion: { (moyaResult) in
                        do {
                          let dematerializedResult = try moyaResult.dematerialize()
                          let filteredResult = try dematerializedResult.filterSuccessfulStatusCodes()
                          let imagesLinksList = try filteredResult.map(ImagesLinksList.self)
                          if let imagesLinks = imagesLinksList.imagesLinks {
                            let imageLinkContainers = imagesLinks.map({ (link) -> ImageLinkContainer in
                              ImageLinkContainer(link: link)
                            })
                            fulfill(imageLinkContainers)
                          } else {
                            throw RemoteServiceError.noData
                          }
                        } catch {
                          reject(error)
                        }
      })
    })
  }
  
}
