//
//  Leagues+CoreDataProperties.swift
//  Sportify
//
//  Created by Ahmed on 5/15/25.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//
//

import Foundation
import CoreData


extension Leagues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Leagues> {
        return NSFetchRequest<Leagues>(entityName: "Leagues")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var key: Int32

}
