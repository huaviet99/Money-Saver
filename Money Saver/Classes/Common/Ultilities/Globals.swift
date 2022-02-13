//
//  Globals.swift
//  Money Saver
//
//  Created by Viet Hua on 2/13/22.
//

import Foundation

typealias SaveCompletionBlock = () -> Void

@objc class Globals: NSObject {
    static let appIdPrefix:String? = Globals.infoForKey("App Identifier Prefix")
    static let appGroupId:String? = Globals.infoForKey("App group Identifier")
    static let serviceName:String? = Globals.infoForKey("Service Name")
    
    class func infoForKey(_ key:String) -> String? {
            return (Bundle.main.infoDictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: "")
        }
}
