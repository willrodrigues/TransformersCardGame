//
//  UpdateTransformerRequestProvider.swift
//  Transformers
//
//  Created by Willian Rodrigues on 17/02/21.
//

import APIService

final class UpdateTransformerRequestProvider: RequestProvider {
    
    // MARK: - RequestProvider
    
    var httpMethod: HTTPMethod { .put }
    var body: [String : Any] { transformer.toJSON() ?? [:] }
    var endpoint: String { "transformers" }
    
    // MARK: - Variables
    
    let transformer: Global.Model.Transformer
    
    // MARK: - LifeCycle
    
    init(transformer: Global.Model.Transformer) {
        self.transformer = transformer
    }
}
