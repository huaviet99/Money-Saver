//
//  CoreDataStackManager.swift
//  Money Saver
//
//  Created by Viet Hua on 2/13/22.
//

import Foundation
import CoreData

public typealias SaveContextCompletionBlock = (NSError?) -> Void
public class CoreDataStackManager: NSObject {
    
    public var coreDataStack: CoreDataStack
    
    init(coreDataStack:CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    public func saveContext(_ managedObjectContext:NSManagedObjectContext, completion:SaveContextCompletionBlock? = nil) {
        managedObjectContext.perform {
            guard managedObjectContext.hasChanges else {
                completion?(nil)
                return
            }
            do {
                try managedObjectContext.save()
                completion?(nil)
            } catch let error as NSError {
                print("[ERROR] : \(error)")
                completion?(error)
            }
        }
    }
    
    public func clearUserDatabaseContent(_ completion: (() -> Void)? = nil)
    {
        let context = self.coreDataStack.getLocalUpdateObjectContext()
        context.perform {
            for entity in self.coreDataStack.managedObjectModel.entities {
                let fetchRequest:NSFetchRequest<NSManagedObject> = NSFetchRequest()
                fetchRequest.entity = entity
                fetchRequest.includesSubentities = false
                do {
                   let result = try context.fetch(fetchRequest)
                    for obj in result {
                            context.delete(obj)
                    }
                    self.saveContext(context, completion: { (_) in
                        completion?()
                    })
                } catch {
                    completion?()
                }
            }
    
        }
    }
    
    func removeDatabaseFiles()
    {
        self.coreDataStack.removeDatabaseFiles()
    }
}
