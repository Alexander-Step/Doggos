//
//  PersistentSaveTasksExecuter.swift
//  Doggos
//
//  Created by Alexander on 4/20/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import CoreData
import PromiseKit

final class PersistentSaveTasksExecuter {
  
  private let persistentContainer: NSPersistentContainer
  private let serialSavingQueue = DispatchQueue(label: "com.Doggos.serialSavingQueue")
  
  var viewContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  // MARK: - Lifecycle
  init() {
    persistentContainer = NSPersistentContainer(name: "Doggos")
  }
  
  init(persistentContainerMock: NSPersistentContainer) {
    persistentContainer = persistentContainerMock
  }
  
  func setupCoreDataStack() {
    persistentContainer.loadPersistentStores { [weak self] (storeDescription, loadStoreError) in
      if let loadStoreError = loadStoreError {
        if let storeURL = storeDescription.url {
          do {
            try FileManager.default.removeItem(at: storeURL)
            self?.setupCoreDataStack()
          } catch {
            fatalError("LoadStoreError: \(loadStoreError) Followed by delete old store error \(error)")
          }
        } else {
          fatalError("LoadStoreError: \(loadStoreError) Followed by oldStoreURL == nil")
        }
      }
    }
    persistentContainer.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    persistentContainer.viewContext.undoManager = nil
    persistentContainer.viewContext.shouldDeleteInaccessibleFaults = true
    persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
  }
  
  // MARK: - Internal
  func save(breeds: [Breed]) -> Promise<[Breed]> {
    return Promise<[Breed]>.init(resolvers: { (fulfill, reject) in
      serialSavingQueue.async { [weak self] in
        guard let existingSelf = self else {
          reject(LocalServiceError.selfIsDeallocated)
          return
        }
        do {
          let saveContext = existingSelf.persistentContainer.newBackgroundContext()
          try existingSelf.clearOldDatabaseBreeds(context: saveContext)
          var savedBreeds = [Breed]()
          try breeds.forEach({ (breed) in
            let breedEntity = try BreedEntity(breed: breed, context: saveContext)
            let savedBreed = try BreedStorage(breedEntity: breedEntity) as Breed
            savedBreeds.append(savedBreed)
          })
          try saveContext.save()
          fulfill(savedBreeds)
        } catch {
          reject(error)
        }
      }
    })
  }
  
  func save(subbreeds: [Subbreed], uplineBreed: Breed) -> Promise<[Subbreed]> {
    return Promise<[Subbreed]>.init(resolvers: { (fulfill, reject) in
      serialSavingQueue.async { [weak self] in
        guard let existingSelf = self else {
          reject(LocalServiceError.selfIsDeallocated)
          return
        }
        do {
          let saveContext = existingSelf.persistentContainer.newBackgroundContext()
          try existingSelf.clearOldDatabaseSubbreeds(uplineBreed: uplineBreed, context: saveContext)
          var savedSubbreeds = [Subbreed]()
          let uplineBreedEntity = try existingSelf.fetchBreedEntity(breed: uplineBreed, context: saveContext)
          try subbreeds.forEach({ (subbreed) in
            let subbreedEntity = try SubbreedEntity(subbreed: subbreed, context: saveContext)
            uplineBreedEntity.addToSubbreeds(subbreedEntity)
            let savedSubbreed = try SubbreedStorage(subbreedEntity: subbreedEntity) as Subbreed
            savedSubbreeds.append(savedSubbreed)
          })
          try saveContext.save()
          fulfill(savedSubbreeds)
        } catch {
          reject(error)
        }
      }
    })
  }
  
  func save(imageLinkContainers: [ImageLinkContainer], uplineBreed: Breed) -> Promise<[ImageLinkContainer]> {
    return Promise<[ImageLinkContainer]>.init(resolvers: { (fulfill, reject) in
      serialSavingQueue.async { [weak self] in
        guard let existingSelf = self else {
          reject(LocalServiceError.selfIsDeallocated)
          return
        }
        do {
          let saveContext = existingSelf.persistentContainer.newBackgroundContext()
          let uplineBreedEntity = try existingSelf.fetchBreedEntity(breed: uplineBreed, context: saveContext)
          try existingSelf.clearOldDatabaseImagesInfo(uplineBreed: uplineBreed, context: saveContext)
          var savedLinkContainers = [ImageLinkContainer]()
          try imageLinkContainers.forEach({ (linkContainer) in
            let linkContainerEntity = try ImageLinkContainerEntity(imageLinkContainer: linkContainer,
                                                                   context: saveContext)
            uplineBreedEntity.addToImages(linkContainerEntity)
            let savedLinkContainer = try ImageLinkContainer(imageLinkContainerEntity: linkContainerEntity)
            savedLinkContainers.append(savedLinkContainer)
          })
          try saveContext.save()
          fulfill(savedLinkContainers)
        } catch {
          reject(error)
        }
      }
    })
  }
  
  func save(imageLinkContainers: [ImageLinkContainer], uplineSubbreed: Subbreed) -> Promise<[ImageLinkContainer]> {
    return Promise<[ImageLinkContainer]>.init(resolvers: { (fulfill, reject) in
      serialSavingQueue.async { [weak self] in
        guard let existingSelf = self else {
          reject(LocalServiceError.selfIsDeallocated)
          return
        }
        do {
          let saveContext = existingSelf.persistentContainer.newBackgroundContext()
          let uplineSubbreedEntity = try existingSelf.fetchSubbreedEntity(subbreed: uplineSubbreed, context: saveContext)
          try existingSelf.clearOldDatabaseImagesInfo(uplineSubbreed: uplineSubbreed, context: saveContext)
          var savedLinkContainers = [ImageLinkContainer]()
          try imageLinkContainers.forEach({ (linkContainer) in
            let linkContainerEntity = try ImageLinkContainerEntity(imageLinkContainer: linkContainer,
                                                                   context: saveContext)
            uplineSubbreedEntity.addToImages(linkContainerEntity)
            let savedLinkContainer = try ImageLinkContainer(imageLinkContainerEntity: linkContainerEntity)
            savedLinkContainers.append(savedLinkContainer)
          })
          try saveContext.save()
          fulfill(savedLinkContainers)
        } catch {
          reject(error)
        }
      }
    })
  }
  
  // MARK: - Private
  // MARK: Fetching from database
  private func fetchBreedEntity(breed: Breed, context: NSManagedObjectContext) throws -> BreedEntity {
    let fetchRequest = BreedEntity.fetchRequestForBreed(name: breed.name)
    if let breedEntity = (try? context.fetch(fetchRequest))?.first {
      return breedEntity
    } else {
      throw LocalServiceError.couldNotFindEntity
    }
  }
  
  private func fetchSubbreedEntity(subbreed: Subbreed, context: NSManagedObjectContext) throws -> SubbreedEntity {
    let fetchRequest = SubbreedEntity.fetchRequestForSubbreed(name: subbreed.name)
    if let subbreedEntity = (try? context.fetch(fetchRequest))?.first {
      return subbreedEntity
    } else {
      throw LocalServiceError.couldNotFindEntity
    }
  }
  
  // MARK: Clearing database
  private func clearOldDatabaseBreeds(context: NSManagedObjectContext) throws {
    let fetchRequest = BreedEntity.fetchRequestForBreed()
    let breedEntities = try context.fetch(fetchRequest)
    try breedEntities.forEach { (breedEntity) in
      try clearOldDatabaseInfo(relatedToBreedEntity: breedEntity, context: context)
    }
  }
  
  private func clearOldDatabaseSubbreeds(uplineBreed: Breed, context: NSManagedObjectContext) throws {
    let fetchRequest = BreedEntity.fetchRequestForBreed(name: uplineBreed.name)
    let breedEntityArray = try context.fetch(fetchRequest)
    try breedEntityArray.forEach { (breedEntity) in
      try breedEntity.subbreeds?.forEach({ (subbreedAsAny) in
        if let subbreedEntity = subbreedAsAny as? SubbreedEntity {
          try clearOldDatabaseInfo(relatedToSubbreedEntity: subbreedEntity, context: context)
        } else {
          throw LocalServiceError.incorrectType
        }
      })
    }
  }
  
  private func clearOldDatabaseImagesInfo(uplineBreed: Breed, context: NSManagedObjectContext) throws {
    let fetchRequest = BreedEntity.fetchRequestForBreed(name: uplineBreed.name)
    let breedEntityArray = try context.fetch(fetchRequest)
    try breedEntityArray.forEach { (breedEntity) in
      try breedEntity.images?.forEach({ (imageLinkContainerAsAny) in
        if let imageLinkContainerEntity = imageLinkContainerAsAny as? ImageLinkContainerEntity {
          context.delete(imageLinkContainerEntity)
        } else {
          throw LocalServiceError.incorrectType
        }
      })
    }
  }
  
  private func clearOldDatabaseImagesInfo(uplineSubbreed: Subbreed, context: NSManagedObjectContext) throws {
    let fetchRequest = SubbreedEntity.fetchRequestForSubbreed(name: uplineSubbreed.name)
    let subbreedEntityArray = try context.fetch(fetchRequest)
    try subbreedEntityArray.forEach { (subbreedEntity) in
      try subbreedEntity.images?.forEach({ (imageLinkContainerAsAny) in
        if let imageLinkContainerEntity = imageLinkContainerAsAny as? ImageLinkContainerEntity {
          context.delete(imageLinkContainerEntity)
        } else {
          throw LocalServiceError.incorrectType
        }
      })
    }
  }
  
  private func clearOldDatabaseInfo(relatedToBreedEntity breedEntity: BreedEntity, context: NSManagedObjectContext) throws {
    try breedEntity.images?.forEach({ (imageContainerAsAny) in
      if let imageContainerEntity = imageContainerAsAny as? ImageLinkContainerEntity {
        context.delete(imageContainerEntity)
      } else {
        throw LocalServiceError.incorrectType
      }
    })
    try breedEntity.subbreeds?.forEach({ (subbreedEntityAsAny) in
      if let subbreedEntity = subbreedEntityAsAny as? SubbreedEntity {
        try clearOldDatabaseInfo(relatedToSubbreedEntity: subbreedEntity, context: context)
      }
    })
    context.delete(breedEntity)
  }
  
  private func clearOldDatabaseInfo(relatedToSubbreedEntity subbreedEntity: SubbreedEntity, context: NSManagedObjectContext) throws {
    try subbreedEntity.images?.forEach({ (imageContainerAsAny) in
      if let imageContainerEntity = imageContainerAsAny as? ImageLinkContainerEntity {
        context.delete(imageContainerEntity)
      } else {
        throw LocalServiceError.incorrectType
      }
    })
    context.delete(subbreedEntity)
  }
  
}
