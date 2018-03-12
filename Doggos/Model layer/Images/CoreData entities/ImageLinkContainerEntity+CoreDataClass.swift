//
//  ImageLinkContainerEntity+CoreDataClass.swift
//  Doggos
//
//  Created by Alexander on 4/23/18.
//  Copyright © 2018 None. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ImageLinkContainerEntity)
public class ImageLinkContainerEntity: NSManagedObject {

  convenience init(imageLinkContainer: ImageLinkContainer, context: NSManagedObjectContext) throws {
    guard let entityDescription = NSEntityDescription.entity(forEntityName: "ImageLinkContainerEntity", in: context)
      else { throw LocalServiceError.couldNotSaveEntity }
    self.init(entity: entityDescription, insertInto: context)
    self.link = imageLinkContainer.link
  }
  
}
