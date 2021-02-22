//
//  TransformerDetailsViewController.swift
//  Transformers
//
//  Created by Willian Rodrigues on 16/02/21.
//

import UIKit
import APIService

protocol TransformerDetailsDisplayLogic: class {
    func displayScreenValues(_ viewModel: TransformerDetails.Model.ViewModel)
    func displayScreenAnimation(animate: Bool)
    func displayHome()
    func displayInvalidTransformer(_ viewModel: TransformerDetails.Model.InvalidMessageViewModel)
}


/**
This viewController is responsable to show the transformer's card and show an edit option.
If any transformer object is provided, It will consider as a new transformer.
 */
final class TransformerDetailsViewController: ScrollableViewController, TransformerDetailsDisplayLogic {
    
    // MARK: - Archtecture Objects
    
    var interactor: TransformerDetailsBusinessLogic?
    var router: (NSObjectProtocol & TransformerDetailsRoutingLogic & TransformerDetailsDataPassing)?
    
    // MARK: - Views
    
    var alertController: UIAlertController?
    
    private lazy var transformerCard = TransformerViewCard(delegate: self)
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spin = UIActivityIndicatorView()
        spin.translatesAutoresizingMaskIntoConstraints = false
        spin.hidesWhenStopped = true
        spin.stopAnimating()
        if #available(iOS 13.0, *) {
            spin.style = .large
        } else {
            spin.style = .whiteLarge
        }
        spin.tintColor = .white
        spin.addAccessibility()
        return spin
    }()
    
    // MARK: - ViewController Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle { .lightContent }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = TransformerDetailsInteractor()
        let presenter = TransformerDetailsPresenter()
        let router = TransformerDetailsRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Private Functions
    
    private func loadScreenValues() {
        interactor?.loadScreenValues()
    }
    
    // MARK: - Layout Functions
    
    private func addComponents() {
        scrollView.addSubview(transformerCard)
        view.addSubview(spinner)
    }
    
    private func addComponentsConstraints() {
        addTransformerCardConstraints()
        addSpinnerConstraints()
    }
    
    private func addTransformerCardConstraints() {
        transformerCard.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        transformerCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        transformerCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        transformerCard.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10).isActive = true
    }
    
    private func addSpinnerConstraints() {
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: - Display Logic
    
    func displayScreenValues(_ viewModel: TransformerDetails.Model.ViewModel) {
        transformerCard.setup(transformer: viewModel.transformer,
                              isEditing: viewModel.isNewTransformer,
                              showEditButton: viewModel.showEditButton)
    }
    
    func displayScreenAnimation(animate: Bool) {
        DispatchQueue.main.async {
            animate ? self.spinner.startAnimating() : self.spinner.stopAnimating()
            self.transformerCard.isUserInteractionEnabled = !animate
        }
    }
    
    func displayHome() {
        DispatchQueue.main.async { self.router?.routeToDismiss() }
    }
    
    func displayInvalidTransformer(_ viewModel: TransformerDetails.Model.InvalidMessageViewModel) {
        let alertController = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: viewModel.button, style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.alertController = alertController
        router?.showAlert()
    }
}

extension TransformerDetailsViewController: TransformerViewCardDelegate {
    func didSave(_ transformer: Global.Model.Transformer) {
        interactor?.save(transformer)
    }
    
    func didDelete(_ id: String) {
        interactor?.delete(id)
    }
}
