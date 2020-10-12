//
//  SettingsEntity+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 12/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension SettingsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SettingsEntity> {
        return NSFetchRequest<SettingsEntity>(entityName: "SettingsEntity")
    }

    @NSManaged public var animationStyle: String
    @NSManaged public var breakPeriods: String
    @NSManaged public var scheduleAlgorithim: String
    @NSManaged public var scheduleDensity: String
    @NSManaged public var dayStartTime: Hour
    @NSManaged public var dayEndTime: Hour
}
