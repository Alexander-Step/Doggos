//
//  PersistentSaverAccesser.swift
//  Doggos
//
//  Created by Alexander on 4/20/18.
//  Copyright © 2018 None. All rights reserved.
//

import PromiseKit
import CoreData

protocol PersistentSaverAccesser: AppDelegateAccessor {
}

extension PersistentSaverAccesser {
  
  // MARK: - Contexts
  func obtainViewContext() -> NSManagedObjectContext {
    let saveTasksExecuter = obtainSaveTasksExecuter()
    return saveTasksExecuter.viewContext
  }
  
  // MARK: - Save methods
  func save(breeds: [Breed]) -> Promise<[Breed]> {
    let saveTasksExecuter = obtainSaveTasksExecuter()
    return saveTasksExecuter.save(breeds: breeds)
  }
  
  func save(subbreeds: [Subbreed], uplineBreed: Breed) -> Promise<[Subbreed]> {
    let saveTasksExecuter = obtainSaveTasksExecuter()
    return saveTasksExecuter.save(subbreeds: subbreeds, uplineBreed: uplineBreed)
  }
  
  func save(linkContainers: [ImageLinkContainer], uplineBreed: Breed) -> Promise<[ImageLinkContainer]> {
    let saveTasksExecuter = obtainSaveTasksExecuter()
    return saveTasksExecuter.save(imageLinkContainers: linkContainers, uplineBreed: uplineBreed)
  }
  
  func save(linkContainers: [ImageLinkContainer], uplineSubbreed: Subbreed) -> Promise<[ImageLinkContainer]> {
    let saveTasksExecuter = obtainSaveTasksExecuter()
    return saveTasksExecuter.save(imageLinkContainers: linkContainers, uplineSubbreed: uplineSubbreed)
  }
  
  // MARK: - Private
  private func obtainSaveTasksExecuter() -> PersistentSaveTasksExecuter {
    let appDelegate = obtainAppDelegate()
    return appDelegate.appDelegateStorage.persistentSaveTasksExecuter
  }
  
}
