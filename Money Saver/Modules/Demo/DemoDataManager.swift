//
//  DemoDataManager.swift
//  Money Saver
//
//  Created by Viet Hua on 2/13/22.
//

import Foundation
import CoreData

final class DemoDataManager: NSObject {
    
    func createDemo(id: String, data: String, completionHandler: SaveCompletionBlock? = nil){
        DataStoreManager.shared.createDemo(id: id, data: data, completionHandler: completionHandler)
    }

    func fetchAllDemos() {
       let list = DataStoreManager.shared.fetchAllDemos()
        for demo in list {
            print("id = \(demo.id) -- data = \(demo.data)")
        }
    }
}
