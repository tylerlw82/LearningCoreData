//
//  Item+CoreDataProperties.swift
//  LearningCoreData
//
//  Created by Tyler Watt on 2021-08-29.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var itemName: String?
    @NSManaged public var objects: NSSet?

    public var unwrappedName: String {
        itemName ?? "Unknown name"
    }

    public var objectsArray: [Object] {
        let objectSet = objects as? Set<Object> ?? []
        
        return objectSet.sorted {
            $0.unwrappedName < $1.unwrappedName
        }
    }
}

// MARK: Generated accessors for objects
extension Item {

    @objc(addObjectsObject:)
    @NSManaged public func addToObjects(_ value: Object)

    @objc(removeObjectsObject:)
    @NSManaged public func removeFromObjects(_ value: Object)

    @objc(addObjects:)
    @NSManaged public func addToObjects(_ values: NSSet)

    @objc(removeObjects:)
    @NSManaged public func removeFromObjects(_ values: NSSet)

}

extension Item : Identifiable {

}
