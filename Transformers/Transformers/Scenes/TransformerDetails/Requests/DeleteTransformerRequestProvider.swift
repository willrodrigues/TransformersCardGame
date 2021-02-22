//
//  DeleteTransformerRequestProvider.swift
//  Transformers
//
//  Created by Willian Rodrigues on 17/02/21.
//

import APIService

final class DeleteTransformerRequestProvider: RequestProvider {
    
    // MARK: - RequestProvider
    
    var httpMethod: HTTPMethod { .delete }
    var body: [String : Any] { [:] }
    var endpoint: String { "transformers/\(transformerID)" }
    
    // MARK: - Variables
    
    let transformerID: String
    
    // MARK: - LifeCycle
    
    init(transformerID: String) {
        self.transformerID = transformerID
    }
}
