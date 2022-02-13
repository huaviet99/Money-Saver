//
//  AppCoordinator.swift
//  Money Saver
//
//  Created by Viet Hua on 2/3/22.
//

import UIKit

class AppCoordinator: NSObject {
    var rootWireFrame: LoginWireframe?
    func setupApplication(launchOptions: [UIApplication.LaunchOptionsKey: Any]?, inWindow window: UIWindow) {
        let appIdPrefix = Globals.appIdPrefix
        let appGroupID = Globals.appGroupId
        let bundleId = Bundle.main.bundleIdentifier ?? ""
        let serviceName = Globals.serviceName ?? ""
        
        MoneySaverApplication.shared.configureFramework(withBundleIdentifier: bundleId, accessGroup: appGroupID, appIdPrefix: appIdPrefix)
        
        self.installRootViewControllerIntoWindow(window)
        window.tintColor = UIColor.red
        window.makeKeyAndVisible()
    }
    
    func installRootViewControllerIntoWindow(_ window: UIWindow){
        rootWireFrame = LoginWireframe()
        rootWireFrame?.presentLoginInterfaceFromWindow(window)
    }
    
}
