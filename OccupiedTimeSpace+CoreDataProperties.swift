//
//  OccupiedTimeSpace+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 06/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension OccupiedTimeSpace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OccupiedTimeSpace> {
        return NSFetchRequest<OccupiedTimeSpace>(entityName: "OccupiedTimeSpace")
    }

    @NSManaged public var color: String?
    @NSManaged public var endTime: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var restFreeSpace: Bool
    @NSManaged public var startTime: Int32
    @NSManaged public var assignedTaskId: UUID?
    @NSManaged public var assignedTaskName: String?
    @NSManaged public var year: Int32
    @NSManaged public var month: Int32
    @NSManaged public var day: Int32

}
