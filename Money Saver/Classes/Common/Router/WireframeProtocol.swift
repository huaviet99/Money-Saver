//
//  WireframeProtocol.swift
//  Money Saver
//
//  Created by Viet Hua on 2/3/22.
//

import UIKit

enum WireframeError: Error {
    case invalidMainViewController
    case invalidParentViewController
}
protocol Wireframe {
    var mainViewController: UIViewController? {get set}
    
    //Navigation Presenter
    func pushInterfaceFromViewController(_ parentViewController: UIViewController, animated: Bool, completion: (() -> Void)?) throws
}

extension Wireframe {
    //MARK: - Navigation Presenter
    func pushInterfaceFromViewController(_ parentViewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) throws {
        guard let viewController = self.mainViewController else { throw WireframeError.invalidMainViewController }
        parentViewController.navigationController?.pushViewController(viewController, animated: animated)
        completion?()
    }
}
