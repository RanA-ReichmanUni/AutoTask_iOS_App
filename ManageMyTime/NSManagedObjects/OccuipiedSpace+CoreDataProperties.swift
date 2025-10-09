//
//  OccuipiedSpace+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 08/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension OccuipiedSpace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OccuipiedSpace> {
        return NSFetchRequest<OccuipiedSpace>(entityName: "OccuipiedSpace")
    }

    @NSManaged public var assignedTaskId: UUID?
    @NSManaged public var assignedTaskName: String?
    @NSManaged public var color: String?
    @NSManaged public var day: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var endTime: Int64
    @NSManaged public var startTime: Int64
    @NSManaged public var month: Int64
    @NSManaged public var year: Int64
    @NSManaged public var restFreeSpace: Bool

}
