//
//  MoneySaverApplication.swift
//  Money Saver
//
//  Created by Viet Hua on 2/13/22.
//

import Foundation

public class MoneySaverApplication {
    public static let shared = MoneySaverApplication()
    
    private init() {
        
    }
    
    public var coreDataStackManager: CoreDataStackManager!
    
    public func configureFramework(withBundleIdentifier bundle:String, accessGroup:String?, appIdPrefix:String?)
       {
           //Setup Managers
           let appName = "MoneySaver"
         
           //Setup Data Layer
           let coreDataConfig = CoreDataStackConfig(modelName: appName, bundleIdentifier: bundle, accessGroup: accessGroup)
           let coreDataStack = CoreDataStack(config: coreDataConfig)
           self.coreDataStackManager = CoreDataStackManager(coreDataStack: coreDataStack)
       }
}
