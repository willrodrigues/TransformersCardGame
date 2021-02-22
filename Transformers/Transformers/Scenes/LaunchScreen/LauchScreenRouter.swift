//
//  LauchScreenRouter.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import UIKit

@objc protocol LauchScreenRoutingLogic {
    func routeToHome()
}

class LauchScreenRouter: NSObject, LauchScreenRoutingLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: LauchScreenViewController?
    
    // MARK: - Routing Logic
    
    func routeToHome() {
        let nextController = HomeViewController()
        nextController.modalPresentationStyle = .fullScreen
        viewController?.present(nextController, animated: true, completion: nil)
    }
    
}
