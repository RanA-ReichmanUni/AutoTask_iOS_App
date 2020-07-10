//
//  Hour+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 07/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension Hour {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hour> {
        return NSFetchRequest<Hour>(entityName: "Hour")
    }

    @NSManaged public var hour: Int
    @NSManaged public var minutes: Int

}
