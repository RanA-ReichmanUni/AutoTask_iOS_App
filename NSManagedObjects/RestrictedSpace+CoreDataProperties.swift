//
//  RestrictedSpace+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 24/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension RestrictedSpace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RestrictedSpace> {
        return NSFetchRequest<RestrictedSpace>(entityName: "RestrictedSpace")
    }

    @NSManaged public var dayOfTheWeek: String
    @NSManaged public var difficulty: String
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var color: String
    @NSManaged public var endTime: Hour
    @NSManaged public var startTime: Hour

}
