//
//  TransformerDetailsPresenter.swift
//  Transformers
//
//  Created by Willian Rodrigues on 16/02/21.
//

import UIKit

protocol TransformerDetailsPresentationLogic {
    func presentScreenValues(_ transformer: Global.Model.Transformer)
    func presentAddTransformer()
    func presentScreenAnimations(animate: Bool)
    func presentHome()
    func presentInvalidTransformer()
}

final class TransformerDetailsPresenter: TransformerDetailsPresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: TransformerDetailsDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues(_ transformer: Global.Model.Transformer) {
        let viewModel = TransformerDetails.Model.ViewModel(transformer: transformer)
        viewController?.displayScreenValues(viewModel)
    }
    
    func presentAddTransformer() {
        let viewModel = TransformerDetails.Model.ViewModel(transformer: nil)
        viewController?.displayScreenValues(viewModel)
    }
    
    func presentScreenAnimations(animate: Bool) {
        viewController?.displayScreenAnimation(animate: animate)
    }
    
    func presentHome() {
        viewController?.displayHome()
    }
    
    func presentInvalidTransformer() {
        let viewModel = TransformerDetails.Model.InvalidMessageViewModel(title: "transformerDetails.invalidTransformer.title".localized,
                                                                         message: "transformerDetails.invalidTransformer.message".localized,
                                                                         button: "transformerDetails.invalidTransformer.button".localized)
        viewController?.displayInvalidTransformer(viewModel)
    }
}
