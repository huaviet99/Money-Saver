//
//  CoreDataStack.swift
//  Money Saver
//
//  Created by Viet Hua on 2/13/22.
//

import UIKit
import CoreData

public class CoreDataStack {
    
    // MARK: - Properties
    let configuration: CoreDataStackConfig
    
    // MARK: - Core Data Stack
    /// A PrivateQueuqConcurrencyType ManagedObjectContext connected directly to the persistent store
    private (set) public lazy var privateManagedObjectContext: NSManagedObjectContext = {
       let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private (set) public lazy var mainObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = self.privateManagedObjectContext
        
        return managedObjectContext
    }()
    
    private (set) public lazy var managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle(for: type(of: self))
        guard let modelURL = bundle.url(forResource: self.configuration.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let storeName = "\(self.configuration.modelName).sqlite"
        let fileManager = FileManager.default
        
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        var persistentStoreURL: URL
        
        if let groupName = self.configuration.accessGroup {
            guard let groupContainerURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: groupName) else {
                fatalError("Unable to find App Group Container")
            }
            persistentStoreURL = groupContainerURL.appendingPathComponent(storeName)
        } else {
            let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            let applicationDocumentsDirectoryURL = urls[urls.count-1]
            persistentStoreURL = applicationDocumentsDirectoryURL.appendingPathComponent(storeName)
        }

        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: self.configuration.persistentStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: options)
        }  catch var error as NSError {
            // Report any error we got.
            var dict:[String : Any] = [:]
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = "There was an error creating or loading the application's saved data."
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "ambi.error", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            fatalError("Unresolved error \(String(describing: error)), \(String(describing: error.userInfo))")
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        return persistentStoreCoordinator
    }()
    
    // MARK: - Initialization
    
    public init(config:CoreDataStackConfig) {
        self.configuration = config
        // Setup Notification Handling
        setupNotificationHandling()
    }
    
    // MARK: - Helper Methods
    /**
     USE WITH CAUTION.  This function removes all database files in the documents directory. Only use this BEFORE the persistent store is setup.
     */
    func removeDatabaseFiles()
    {
        do {
            let fileManager = FileManager.default
            var persistentStoreURL: URL
            if let groupName = configuration.accessGroup {
                guard let groupContainerURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: groupName) else {
                    fatalError("Unable to find App Group Container")
                }
                persistentStoreURL = groupContainerURL
            } else {
                let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
                let applicationDocumentsDirectoryURL = urls[urls.count-1]
                persistentStoreURL = applicationDocumentsDirectoryURL
            }

            let localDocumentURLs = try fileManager.contentsOfDirectory(at: persistentStoreURL,
                                                                        includingPropertiesForKeys: nil,
                                                                        options: FileManager.DirectoryEnumerationOptions.skipsSubdirectoryDescendants)
            
            let filteredArray = localDocumentURLs.filter { $0.absoluteString.range(of: "\(configuration.modelName).sqlite") != nil }
            filteredArray.forEach { (url) in
                do {
                    try fileManager.removeItem(at: url)
                    print("Remove item at: \(url.absoluteString)")
                } catch let error {
                    print("Failed to remove item at : \(url.absoluteString) with Error: \(error)")
                }
            }
        } catch let error {
             print("Failed to cleanup Database Files with Error: \(error)")
        }
        
    }
    private func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(CoreDataStack.saveChanges(_:)),
                                       name: UIApplication.willTerminateNotification,
                                       object: nil)
        notificationCenter.addObserver(self, selector: #selector(CoreDataStack.saveChanges(_:)),
                                       name: UIApplication.didEnterBackgroundNotification,
                                       object: nil)
    }
    
    public func getLocalUpdateObjectContext() -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.parent = self.mainObjectContext
        return managedObjectContext
    }
    
    /// Create a child ManagedObjectContext from the PrivateManagedObject. Used for DB update comming from the server.
    public func getCloudUpdateObjectContext() -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.parent = self.privateManagedObjectContext
        NotificationCenter.default.addObserver(self, selector: #selector(managedObjectContextObjectsDidSave), name: NSNotification.Name.NSManagedObjectContextDidSave, object: managedObjectContext)
        return managedObjectContext
    }
    // MARK: - Notification Handling
    @objc func managedObjectContextObjectsDidSave(notification:Notification) {
        self.mainObjectContext.performAndWait { [weak self] in
            self?.mainObjectContext.mergeChanges(fromContextDidSave: notification)
        }
    }
    
    @objc func saveChanges(_ notification: NSNotification) {

        mainObjectContext.perform {
            do {
                if self.mainObjectContext.hasChanges {
                    try self.mainObjectContext.save()
                }
            } catch {
                let saveError = error as NSError
                print("Unable to Save Changes of Managed Object Context")
                print("\(saveError), \(saveError.localizedDescription)")
            }
            
            self.privateManagedObjectContext.perform {
                do {
                    if self.privateManagedObjectContext.hasChanges {
                        try self.privateManagedObjectContext.save()
                    }
                } catch {
                    let saveError = error as NSError
                    print("Unable to Save Changes of Private Managed Object Context")
                    print("\(saveError), \(saveError.localizedDescription)")
                }
            }
            
        }
    }
}
