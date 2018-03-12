//
//  SubbreedEntity+CoreDataClass.swift
//  Doggos
//
//  Created by Alexander on 4/23/18.
//  Copyright © 2018 None. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SubbreedEntity)
public class SubbreedEntity: NSManagedObject {
  
  convenience init(subbreed: Subbreed, context: NSManagedObjectContext) throws {
    guard let entityDescription = NSEntityDescription.entity(forEntityName: "SubbreedEntity", in: context)
      else { throw LocalServiceError.couldNotSaveEntity }
    self.init(entity: entityDescription, insertInto: context)
    name = subbreed.name
    if let existingImageLinks = subbreed.images {
      try existingImageLinks.forEach { (imageLinkContainer) in
        let imageEntity = try ImageLinkContainerEntity(imageLinkContainer: imageLinkContainer, context: context)
        imageEntity.toSubbreed = self
        addToImages(imageEntity)
      }
    }
  }

}
