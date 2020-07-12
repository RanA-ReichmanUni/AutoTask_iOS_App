//
//  FreeSpace+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 12/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension FreeSpace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FreeSpace> {
        return NSFetchRequest<FreeSpace>(entityName: "FreeSpace")
    }

    @NSManaged public var fullyOccupiedDay: Bool
    @NSManaged public var id: UUID
    @NSManaged public var duration: Hour
    @NSManaged public var ending: Hour
    @NSManaged public var starting: Hour
    @NSManaged public var date: CustomDate

}
