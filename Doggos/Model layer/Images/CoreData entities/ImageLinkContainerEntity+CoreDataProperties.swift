//
//  ImageLinkContainerEntity+CoreDataProperties.swift
//  Doggos
//
//  Created by Alexander on 4/23/18.
//  Copyright © 2018 None. All rights reserved.
//
//

import Foundation
import CoreData

extension ImageLinkContainerEntity {

    @nonobjc public class func fetchRequestForImageLinkContainer() -> NSFetchRequest<ImageLinkContainerEntity> {
        return NSFetchRequest<ImageLinkContainerEntity>(entityName: "ImageLinkContainerEntity")
    }

    @NSManaged public var link: String?
    @NSManaged public var toBreed: BreedEntity?
    @NSManaged public var toSubbreed: SubbreedEntity?

}
