//
//  BreedEntity+CoreDataClass.swift
//  Doggos
//
//  Created by Alexander on 4/23/18.
//  Copyright © 2018 None. All rights reserved.
//
//

import Foundation
import CoreData

@objc(BreedEntity)
public class BreedEntity: NSManagedObject {
  
  convenience init(breed: Breed, context: NSManagedObjectContext) throws {
    guard let entityDescription = NSEntityDescription.entity(forEntityName: "BreedEntity", in: context)
      else { throw LocalServiceError.couldNotSaveEntity }
    self.init(entity: entityDescription, insertInto: context)
    name = breed.name
    if let existingSubbreeds = breed.subbreeds {
      try existingSubbreeds.forEach { (subbreed) in
        let subbreedEntity = try SubbreedEntity(subbreed: subbreed, context: context)
        subbreedEntity.toBreed = self
        addToSubbreeds(subbreedEntity)
      }
    }
    if let existingImageLinks = breed.images {
      try existingImageLinks.forEach { (imageLinkContainer) in
        let imageLinkContainerEntity =
          try ImageLinkContainerEntity(imageLinkContainer: imageLinkContainer, context: context)
        imageLinkContainerEntity.toBreed = self
        addToImages(imageLinkContainerEntity)
      }
    }
  }

}
