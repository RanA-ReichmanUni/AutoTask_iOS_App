//
//  FreeTaskSpace+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 10/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension FreeTaskSpace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FreeTaskSpace> {
        return NSFetchRequest<FreeTaskSpace>(entityName: "FreeTaskSpace")
    }

    @NSManaged public var fullyOccupiedDay: Bool
    @NSManaged public var id: UUID
    @NSManaged public var associatedId: UUID?
    @NSManaged public var date: CustomDate
    @NSManaged public var duration: Hour
    @NSManaged public var ending: Hour
    @NSManaged public var starting: Hour

}
