//
//  LoginWireframe.swift
//  Money Saver
//
//  Created by Viet Hua on 2/3/22.
//

import UIKit

class LoginWireframe: Wireframe {
    var mainViewController: UIViewController?
    
    private var loginViewModel: LoginViewModel
    private var demoWireframe: DemoWireframe?

    init() {
        loginViewModel = LoginViewModel()
        self.loginViewModel.loginWireframe = self
    }
    
    func presentLoginInterfaceFromWindow(_ window: UIWindow){
        let loginViewController = LoginViewController()
        loginViewController.loginViewModel = loginViewModel
        self.mainViewController = loginViewController
        
        let navigationController = UINavigationController(rootViewController: self.mainViewController!)
        window.rootViewController = navigationController
    }
    
    func openDemo(){
        guard let parentView = self.mainViewController else { return }
        self.demoWireframe = DemoWireframe()
        demoWireframe?.pushDemoInterfaceFromViewController(parentView, animated: true)
    }
}
