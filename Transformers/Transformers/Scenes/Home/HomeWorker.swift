//
//  HomeWorker.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import APIService

protocol HomeWorkerLogic {
    func getTransformers(_ request: RequestProvider, completion: @escaping (Result<Home.Model.Response, APIError>) -> Void)
}

final class HomeWorker: HomeWorkerLogic {
    func getTransformers(_ request: RequestProvider, completion: @escaping (Result<Home.Model.Response, APIError>) -> Void) {
        APIService.shared.fetch(model: Home.Model.Response.self, request: request, completion: completion)
    }
}
