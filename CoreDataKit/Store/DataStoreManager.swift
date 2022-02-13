//
//  DataStoreManager.swift
//  Money Saver
//
//  Created by Viet Hua on 2/13/22.
//

import Foundation
import CoreData

protocol DataStoreManagerProtocol {
    func fetchAllDemos() -> [ManagedDemo]
    func createDemo(id: String, data: String, completionHandler: SaveCompletionBlock?)
    
}

final class DataStoreManager: NSObject, DataStoreManagerProtocol {
    
    static let shared = DataStoreManager()
    
    // MARK: - Core Data Saving support
    
    func saveContext (_ completionHandler: SaveCompletionBlock? = nil)
    {
        let moc = MoneySaverApplication.shared.coreDataStackManager.coreDataStack.mainObjectContext
        moc.perform({ () -> Void in
            if moc.hasChanges {
                do {
                    try moc.save()
                    completionHandler?()
                    let pmoc = MoneySaverApplication.shared.coreDataStackManager.coreDataStack.privateManagedObjectContext
                    pmoc.perform({ () -> Void in
                        if pmoc.hasChanges {
                            do {
                                try pmoc.save()
                            } catch let error as NSError {
                            } catch {
                                fatalError()
                            }
                        }
                    })
                    
                } catch let error as NSError {
                    completionHandler?()
                } catch {
                    fatalError()
                }
            } else {
                completionHandler?()
            }
        })
    }
    
    func saveContext (_ temporaryManagedObjectContext: NSManagedObjectContext?, completionHandler: SaveCompletionBlock? = nil)
    {
        if let tmoc = temporaryManagedObjectContext {
            tmoc.perform({ () -> Void in
                if tmoc.hasChanges {
                    do {
                        try tmoc.save()
                        self.saveContext(completionHandler)
                    } catch let error as NSError {
                        completionHandler?()
                    }
                } else {
                    completionHandler?()
                }
            })
        }
    }
    
    func createDemo(id: String, data: String, completionHandler: SaveCompletionBlock?) {
        //Create a new demo
        let moc = MoneySaverApplication.shared.coreDataStackManager.coreDataStack.getLocalUpdateObjectContext()
        moc.performAndWait({ () -> Void in
            
            let _ = ManagedDemo.create(withId: id, forData: data, inContext: moc)
            
            DataStoreManager.shared.saveContext(moc, completionHandler: completionHandler)
        })
    }
    
    func fetchAllDemos() -> [ManagedDemo] {
        ManagedDemo.fetchAll(context: MoneySaverApplication.shared.coreDataStackManager.coreDataStack.mainObjectContext)}
}
