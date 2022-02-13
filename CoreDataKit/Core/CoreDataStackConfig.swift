//
//  CoreDataStackConfig.swift
//  Money Saver
//
//  Created by Viet Hua on 2/13/22.
//

import Foundation
import CoreData

public final class CoreDataStackConfig: CustomStringConvertible {
    
    public let persistentStoreType:String
    public let modelName: String
    public let bundleIdentifier: String
    public let accessGroup: String?
    
    public init(storeType:String = NSSQLiteStoreType, modelName: String, bundleIdentifier: String, accessGroup: String?) {
        self.persistentStoreType = storeType
        self.modelName = modelName
        self.bundleIdentifier = bundleIdentifier
        self.accessGroup = accessGroup
    }
    public var description: String {
        return "StoreType: \(self.persistentStoreType) ModelName: \(self.modelName) BundleId: \(self.bundleIdentifier) AccessGroup:\(String(describing: self.accessGroup))"
    }
}
