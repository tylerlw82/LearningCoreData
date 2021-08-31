//
//  Object+CoreDataProperties.swift
//  LearningCoreData
//
//  Created by Tyler Watt on 2021-08-29.
//
//

import Foundation
import CoreData


extension Object {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Object> {
        return NSFetchRequest<Object>(entityName: "Object")
    }

    @NSManaged public var objectName: String?
    @NSManaged public var item: Item?

    public var unwrappedName: String {
        objectName ?? "Unknown name"
    }
}

extension Object : Identifiable {

}
