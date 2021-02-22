//
//  TransformerDetailsWorker.swift
//  Transformers
//
//  Created by Willian Rodrigues on 16/02/21.
//

import APIService

final class TransformerDetailsWorker {
    
    func save(_ request: RequestProvider, completion: @escaping (Result<Global.Model.Transformer, APIError>) -> Void) {
        APIService.shared.fetch(model: Global.Model.Transformer.self, request: request, completion: completion)
    }
    
    func delete(_ request: RequestProvider, completion: @escaping (Result<APISuccess, APIError>) -> Void) {
        APIService.shared.fetch(request: request, completion: completion)
    }
}
