//
//  SettingsEntity+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 27/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension SettingsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SettingsEntity> {
        return NSFetchRequest<SettingsEntity>(entityName: "SettingsEntity")
    }

    @NSManaged public var scheduleAlgorithim: String
    @NSManaged public var scheduleDensity: String
    @NSManaged public var breakPeriods: String

}
