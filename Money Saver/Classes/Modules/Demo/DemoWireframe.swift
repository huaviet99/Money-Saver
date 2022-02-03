//
//  DemoWireframe.swift
//  Money Saver
//
//  Created by Viet Hua on 2/3/22.
//

import UIKit

class DemoWireframe: Wireframe {
    private var demoViewModel: DemoViewModel
    var mainViewController: UIViewController?
    
    init() {
        demoViewModel = DemoViewModel()
    }
    
    func presentDemoInterfaceFromWindow(_ window: UIWindow){
        let demoViewController  = DemoViewController()
        demoViewController.demoViewModel = demoViewModel
        self.mainViewController = demoViewController
        
        let navigationController = UINavigationController(rootViewController: self.mainViewController!)
        window.rootViewController = navigationController
    }
}
