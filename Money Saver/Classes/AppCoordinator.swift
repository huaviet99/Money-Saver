//
//  AppCoordinator.swift
//  Money Saver
//
//  Created by Viet Hua on 2/3/22.
//

import UIKit

class AppCoordinator: NSObject {
    
    func setupApplication(launchOptions: [UIApplication.LaunchOptionsKey: Any]?, inWindow window: UIWindow) {
     
        self.installRootViewControllerIntoWindow(window)
        window.tintColor = UIColor.red
        window.makeKeyAndVisible()
    }
    
    func installRootViewControllerIntoWindow(_ window: UIWindow){
        let mainViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window.rootViewController = navigationController
    }
    
}
