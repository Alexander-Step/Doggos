//
//  DoggosTypesService.swift
//  Doggos
//
//  Created by Alexander on 3/16/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

class DoggoTypesRemoteService {
  private let provider: DoggosMoyaProvider<DoggosAPI>
  
  // MARK: - Lifecycle
  init(_ newProvider: DoggosMoyaProvider<DoggosAPI>) {
    provider = newProvider
  }
  
  convenience init() {
    self.init(DoggosMoyaProvider<DoggosAPI>())
  }
  
  // MARK: - Internal
  func loadBreedList() -> Promise<[Breed]> {
    return Promise<[Breed]>(resolvers: { (fulfill, reject) in
      provider.request(.loadBreedList,
                       callbackQueue: DispatchQueue.global(qos: .default),
                       completion: { (moyaResult) in
                        do {
                          let dematerializedResult = try moyaResult.dematerialize()
                          let filteredResult = try dematerializedResult.filterSuccessfulStatusCodes()
                          let doggosTypesList = try filteredResult.map(DoggosTypesList.self)
                          let breeds = BreedStorage.breeds(from: doggosTypesList) as [Breed]
                          fulfill(breeds)
                        } catch {
                          reject(error)
                        }
      })
    })
  }

  func loadSubbreedList(breed: Breed) -> Promise<[Subbreed]> {
    return Promise<[Subbreed]>(resolvers: { (fulfill, reject) in
      provider.request(.loadSubbreedList(breed: breed.name),
                       callbackQueue: DispatchQueue.global(qos: .default),
                       completion: { (moyaResult) in
                        do {
                          let dematerializedResult = try moyaResult.dematerialize()
                          let filteredResult = try dematerializedResult.filterSuccessfulStatusCodes()
                          let doggosTypesList = try filteredResult.map(DoggosTypesList.self)
                          let subbreeds = SubbreedStorage.subbreeds(from: doggosTypesList)
                          fulfill(subbreeds)
                        } catch {
                          reject(error)
                        }
      })
    })
  }
}
