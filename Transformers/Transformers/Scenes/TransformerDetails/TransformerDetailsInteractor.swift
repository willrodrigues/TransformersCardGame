//
//  TransformerDetailsInteractor.swift
//  Transformers
//
//  Created by Willian Rodrigues on 16/02/21.
//

import UIKit
import APIService

protocol TransformerDetailsBusinessLogic {
    func loadScreenValues()
    func save(_ transformer: Global.Model.Transformer)
    func delete(_ id: String)
}

protocol TransformerDetailsDataStore {
    var selectedTransformer: Global.Model.Transformer? { get set }
}

final class TransformerDetailsInteractor: TransformerDetailsBusinessLogic, TransformerDetailsDataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: TransformerDetailsPresentationLogic?
    let worker: TransformerDetailsWorker
    
    // MARK: - Variable
    
    var isFetching: Bool = false {
        didSet { presenter?.presentScreenAnimations(animate: isFetching) }
    }
    
    //MARK: - DataStore Objects
    
    var selectedTransformer: Global.Model.Transformer?
    
    // MARK: - Interactor Lifecycle
    
    init(worker: TransformerDetailsWorker = TransformerDetailsWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues() {
        guard let transformer = selectedTransformer else {
            presenter?.presentAddTransformer()
            return
        }
        presenter?.presentScreenValues(transformer)
    }
    
    func save(_ transformer: Global.Model.Transformer) {
        guard checkValid(transformer) else { return }
        isFetching = true
        transformer.id == nil ? add(transformer) : update(transformer)
    }
    
    func delete(_ id: String) {
        guard !id.isEmpty else { return }
        isFetching = true
        let request = DeleteTransformerRequestProvider(transformerID: id)
        worker.delete(request, completion: handleDeleteResponse)
    }
    
    // MARK: - Private Functions
    
    private func checkValid(_ transformer: Global.Model.Transformer) -> Bool {
        let isValid = !transformer.name.isEmpty && transformer.team != .unknown
        if !isValid { presenter?.presentInvalidTransformer() }
        return isValid
    }
    
    private func add(_ transformer: Global.Model.Transformer) {
        let request = AddTransformerRequestProvider(transformer: transformer)
        worker.save(request, completion: handleAddResponse)
    }
    
    private func update(_ transformer: Global.Model.Transformer) {
        let request = UpdateTransformerRequestProvider(transformer: transformer)
        worker.save(request, completion: handleUpdateResponse)
    }
    
    
    // MARK: - Handle Responses
    
    private func handleUpdateResponse(_ result: (Result<Global.Model.Transformer, APIError>)) {
        switch result {
        case .success(let response):
            selectedTransformer = response
            selectedTransformer?.edited = .updated
            presenter?.presentHome()
        case .failure( let error ):
            print(error.localizedDescription)
        }
        isFetching = false
    }
    
    private func handleAddResponse(_ result: (Result<Global.Model.Transformer, APIError>)) {
        switch result {
        case .success(let response):
            selectedTransformer = response
            selectedTransformer?.edited = .added
            presenter?.presentHome()
        case .failure( let error ):
            print(error.localizedDescription)
        }
        isFetching = false
    }
    
    private func handleDeleteResponse(_ result: (Result<APISuccess, APIError>)) {
        switch result {
        case .success(let response):
            switch response {
            case .success:
                selectedTransformer?.edited = .deleted
                presenter?.presentHome()
            case .failure(let error):
                print(error)
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
        isFetching = true
    }
    
}
