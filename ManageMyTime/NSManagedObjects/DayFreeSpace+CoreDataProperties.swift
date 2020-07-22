//
//  DayFreeSpace+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 22/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension DayFreeSpace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayFreeSpace> {
        return NSFetchRequest<DayFreeSpace>(entityName: "DayFreeSpace")
    }

    @NSManaged public var dayOfTheWeek: String
    @NSManaged public var id: UUID
    @NSManaged public var fullyRestrictedDay: Bool
    @NSManaged public var duration: Hour
    @NSManaged public var endTime: Hour
    @NSManaged public var startTime: Hour

}
