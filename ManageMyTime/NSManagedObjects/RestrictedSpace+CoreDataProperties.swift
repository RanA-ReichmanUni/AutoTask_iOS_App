//
//  RestrictedSpace+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 06/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension RestrictedSpace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RestrictedSpace> {
        return NSFetchRequest<RestrictedSpace>(entityName: "RestrictedSpace")
    }

    @NSManaged public var id: UUID
    @NSManaged public var startTime: Date
    @NSManaged public var endTime: Date
    @NSManaged public var dayOfTheWeek: String

}
