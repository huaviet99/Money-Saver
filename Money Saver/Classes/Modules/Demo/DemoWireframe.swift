//
//  DemoWireframe.swift
//  Money Saver
//
//  Created by Viet Hua on 2/3/22.
//

import UIKit

class DemoWireframe: Wireframe {
    var mainViewController: UIViewController?
    
    //Modal
    func presentDemoInterfaceFromViewController(_ parentViewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        let demoViewController = DemoViewController()
        self.mainViewController = demoViewController
        
        let navigationController = UINavigationController(rootViewController: self.mainViewController!)
        parentViewController.present(navigationController, animated: animated, completion: completion)
    }
    
    //New Interface
    func pushDemoInterfaceFromViewController(_ parentViewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        let demoViewController = DemoViewController()
        self.mainViewController = demoViewController
        
        parentViewController.navigationController?.pushViewController(self.mainViewController!, animated: animated)
    }
}
