//
//  HomeRouter.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import UIKit

@objc protocol HomeRoutingLogic {
    func routeToTransformerDetails()
    func routeToCreateTransformer()
    func routeToMessage()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    // MARK: - Routing Logic
    
    func routeToTransformerDetails() {
        let nextController = TransformerDetailsViewController()
        var destinationDS = nextController.router?.dataStore
        passDataToSomewhere(source: dataStore, destination: &destinationDS)
        viewController?.present(nextController, animated: true)
    }
    
    func routeToCreateTransformer() {
        let nextController = TransformerDetailsViewController()
        viewController?.present(nextController, animated: true)
    }
    
    func routeToMessage() {
        guard let alert = viewController?.alertController else { return }
        viewController?.present(alert, animated: true)
    }
    
    // MARK: - Passing data
    
    func passDataToSomewhere(source: HomeDataStore?, destination: inout TransformerDetailsDataStore?) {
        destination?.selectedTransformer = source?.selectedTransformer
    }
}
