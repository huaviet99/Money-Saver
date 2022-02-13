//
//  DemoViewModel.swift
//  Money Saver
//
//  Created by Viet Hua on 2/3/22.
//

import Foundation

class DemoViewModel {
    weak var demoWireframe: DemoWireframe?

    private let demoDataManager = DemoDataManager()
    
    func createDemo(){
        let randomInt = Int.random(in: 0..<100)

        demoDataManager.createDemo(id: String(randomInt), data: "Hello \(randomInt)", completionHandler: {
            print("Completion called")
        })
    }
    
    func fetchAllDemos(){
        demoDataManager.fetchAllDemos()
    }
}
