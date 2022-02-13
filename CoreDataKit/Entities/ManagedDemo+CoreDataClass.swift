//
//  ManagedDemo+CoreDataClass.swift
//  Money Saver
//
//  Created by Viet Hua on 2/13/22.
//
//

import Foundation
import CoreData

@objc(ManagedDemo)
public class ManagedDemo: NSManagedObject {
    // MARK: - CREATE
    public class func create(withId id: String, forData data: String, inContext context: NSManagedObjectContext) -> ManagedDemo {
        
        //Create a new instance
        let entity = NSEntityDescription.entity(forEntityName: "Demo", in: context)
        
        let demo = NSManagedObject(entity: entity!, insertInto: context) as! ManagedDemo
        demo.id = id
        demo.data = data
        return demo
    }
    
    public class func fetchAll(context: NSManagedObjectContext) -> [ManagedDemo] {
        let fetchRequest: NSFetchRequest<ManagedDemo> = self.fetchRequest()
        fetchRequest.fetchLimit = 0
        
        let sorter  = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sorter]
        
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            return []
        }
    }
}
