//
//  HomeRequestProvider.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import APIService

final class HomeRequestProvider: RequestProvider {
    var httpMethod: HTTPMethod { .get }
    var body: [String : Any] { [:] }
    var endpoint: String { "transformers" }
}
