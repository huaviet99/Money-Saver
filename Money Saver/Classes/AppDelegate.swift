//
//  AppDelegate.swift
//  Money Saver
//
//  Created by Viet Hua on 1/19/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let appCoordinator = AppCoordinator()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator.setupApplication(launchOptions: launchOptions, inWindow: self.window!)
        return true
    }
    
}

