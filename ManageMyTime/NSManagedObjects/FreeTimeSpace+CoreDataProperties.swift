//
//  FreeTimeSpace+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 07/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension FreeTimeSpace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FreeTimeSpace> {
        return NSFetchRequest<FreeTimeSpace>(entityName: "FreeTimeSpace")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var day: Int64
    @NSManaged public var month: Int64
    @NSManaged public var year: Int64
    @NSManaged public var startTime: TimeByHour
    @NSManaged public var endTime: TimeByHour
    @NSManaged public var duration: TimeByHour

}
