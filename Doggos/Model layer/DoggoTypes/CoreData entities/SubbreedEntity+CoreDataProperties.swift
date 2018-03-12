//
//  SubbreedEntity+CoreDataProperties.swift
//  Doggos
//
//  Created by Alexander on 4/23/18.
//  Copyright © 2018 None. All rights reserved.
//
//

import Foundation
import CoreData

extension SubbreedEntity {

    @nonobjc public class func fetchRequestForSubbreed() -> NSFetchRequest<SubbreedEntity> {
        return NSFetchRequest<SubbreedEntity>(entityName: "SubbreedEntity")
    }
  
    @nonobjc public class func fetchRequestForSubbreed(name: String) -> NSFetchRequest<SubbreedEntity> {
      let namePredicate = NSPredicate.init(format: "name == %@", name)
      let fetchRequest = NSFetchRequest<SubbreedEntity>(entityName: "SubbreedEntity")
      fetchRequest.predicate = namePredicate
      return fetchRequest
    }

    @NSManaged public var name: String?
    @NSManaged public var images: NSSet?
    @NSManaged public var toBreed: BreedEntity?

}

// MARK: Generated accessors for images
extension SubbreedEntity {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: ImageLinkContainerEntity)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: ImageLinkContainerEntity)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}
