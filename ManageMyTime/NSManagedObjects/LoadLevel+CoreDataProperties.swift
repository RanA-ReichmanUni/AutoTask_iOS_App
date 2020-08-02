//
//  LoadLevel+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 02/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension LoadLevel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoadLevel> {
        return NSFetchRequest<LoadLevel>(entityName: "LoadLevel")
    }

    @NSManaged public var id: UUID
    @NSManaged public var loadLevel: CGFloat
    @NSManaged public var date: CustomDate

}
