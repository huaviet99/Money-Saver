//
//  ManagedDemo+CoreDataProperties.swift
//  Money Saver
//
//  Created by Viet Hua on 2/13/22.
//
//

import Foundation
import CoreData


extension ManagedDemo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedDemo> {
        return NSFetchRequest<ManagedDemo>(entityName: "Demo")
    }

    @NSManaged public var id: String?
    @NSManaged public var data: String?

}

