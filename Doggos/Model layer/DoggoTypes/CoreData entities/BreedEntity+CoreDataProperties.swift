//
//  BreedEntity+CoreDataProperties.swift
//  Doggos
//
//  Created by Alexander on 4/23/18.
//  Copyright © 2018 None. All rights reserved.
//
//

import Foundation
import CoreData

extension BreedEntity {

    @nonobjc public class func fetchRequestForBreed() -> NSFetchRequest<BreedEntity> {
        return NSFetchRequest<BreedEntity>(entityName: "BreedEntity")
    }
  
    @nonobjc public class func fetchRequestForBreed(name: String) -> NSFetchRequest<BreedEntity> {
      let namePredicate = NSPredicate.init(format: "name == %@", name)
      let fetchRequest = NSFetchRequest<BreedEntity>(entityName: "BreedEntity")
      fetchRequest.predicate = namePredicate
      return fetchRequest
    }

    @NSManaged public var name: String?
    @NSManaged public var images: NSSet?
    @NSManaged public var subbreeds: NSSet?

}

// MARK: Generated accessors for images
extension BreedEntity {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: ImageLinkContainerEntity)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: ImageLinkContainerEntity)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}

// MARK: Generated accessors for subbreeds
extension BreedEntity {

    @objc(addSubbreedsObject:)
    @NSManaged public func addToSubbreeds(_ value: SubbreedEntity)

    @objc(removeSubbreedsObject:)
    @NSManaged public func removeFromSubbreeds(_ value: SubbreedEntity)

    @objc(addSubbreeds:)
    @NSManaged public func addToSubbreeds(_ values: NSSet)

    @objc(removeSubbreeds:)
    @NSManaged public func removeFromSubbreeds(_ values: NSSet)

}
