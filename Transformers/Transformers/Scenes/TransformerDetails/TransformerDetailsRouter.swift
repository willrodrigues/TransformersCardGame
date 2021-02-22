//
//  TransformerDetailsRouter.swift
//  Transformers
//
//  Created by Willian Rodrigues on 16/02/21.
//

import UIKit

@objc protocol TransformerDetailsRoutingLogic {
    func routeToDismiss()
    func showAlert()
}

protocol TransformerDetailsDataPassing {
    var dataStore: TransformerDetailsDataStore? { get }
}

final class TransformerDetailsRouter: NSObject, TransformerDetailsRoutingLogic, TransformerDetailsDataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: TransformerDetailsViewController?
    var dataStore: TransformerDetailsDataStore?
    
    // MARK: - Routing Logic
    
    func routeToDismiss() {
        let homeVC = viewController?.presentingViewController as? HomeViewController
        var destinationDS = homeVC?.router?.dataStore
        passDataToSomewhere(source: dataStore, destination: &destinationDS)
        viewController?.dismiss(animated: true)
    }
    
    func showAlert() {
        guard let alert = viewController?.alertController else { return }
        viewController?.present(alert, animated: true)
    }
    
    // MARK: - Passing data
    
    func passDataToSomewhere(source: TransformerDetailsDataStore?, destination: inout HomeDataStore?) {
        destination?.selectedTransformer = source?.selectedTransformer
    }
}
