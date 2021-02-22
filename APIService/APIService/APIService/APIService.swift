//
//  APIService.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import Foundation

public enum APIError: Error {
    case badURL, requestFailed(String), mappingError, tokenError, unknown
}

public enum APISuccess {
    case success
    case failure(String)
}

public protocol APIServiceProtocol {
    func fetch<T: Codable>(model: T.Type, request: RequestProvider, completion: @escaping (Result<T, APIError>) -> Void)
    func fetch(request: RequestProvider, completion: @escaping (Result<APISuccess, APIError>) -> Void)
}

final public class APIService: APIServiceProtocol {
    
    // MARK: - Singleton
    
    public static let shared: APIServiceProtocol = APIService()
    
    // MARK: - UserDefaults
    
    let userDefaults: UserDefaults
    let tokenDefaultsID = "tokenStorage"
    
    // MARK: - Session
    
    let urlSession: URLSession
    
    // MARK: - Lifecycle
    
    private init(userDefaults: UserDefaults = UserDefaults.standard,
                 urlSession: URLSession = URLSession.shared) {
        self.userDefaults = userDefaults
        self.urlSession = urlSession
    }
    
    // MARK: - Variables
    
    var tokenStorage: String? {
        get { userDefaults.string(forKey: tokenDefaultsID)}
        set { userDefaults.set(newValue, forKey: tokenDefaultsID) }
    }
    
    // MARK: - Functions
    
    public func fetch<T: Codable>(model: T.Type, request: RequestProvider, completion: @escaping (Result<T, APIError>) -> Void) {
        getToken { token in
            guard let token = token else { completion(.failure(.tokenError)); return }
            guard let urlRequest = self.createURLRequest(request: request, token: token) else { completion(.failure(.badURL)); return }
            self.urlSession.dataTask(with: urlRequest) { data, response, error in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let data = data,
                      let response = try? decoder.decode(model, from: data) else { completion(.failure(.mappingError)); return }
                completion(.success(response))
            }.resume()
        }
    }
    
    public func fetch(request: RequestProvider, completion: @escaping (Result<APISuccess, APIError>) -> Void) {
        getToken { token in
            guard let token = token else { completion(.failure(.tokenError)); return }
            guard let urlRequest = self.createURLRequest(request: request, token: token) else { completion(.failure(.badURL)); return }
            self.urlSession.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else { completion(.failure(.requestFailed("[ERROR] \(error?.localizedDescription ?? "")"))); return }
                guard let response = response as? HTTPURLResponse else { completion(.failure(.requestFailed("[ERROR] No response"))); return }
                guard 200..<300 ~= response.statusCode else { completion(.success(.failure("[LOG] Response Status Code: \(response.statusCode)"))); return }
                completion(.success(.success))
            }.resume()
        }
    }
    
    // MARK: - Private Functions
    
    private func getToken(completion: @escaping (String?)-> Void) {
        if let tokenStorage = tokenStorage {
            completion(tokenStorage)
        } else {
            guard let url = URL(string: Constants.baseURL + Constants.tokenPath) else { completion(nil); return }
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.get.value
            urlSession.dataTask(with: request) { data, response, error in
                guard let data = data else { completion(nil); return }
                let response: String? = String(decoding: data, as: UTF8.self)
                self.tokenStorage = response
                completion(response)
            }.resume()
        }
    }
    
    private func createURLRequest(request: RequestProvider, token: String) -> URLRequest? {
        guard let url = URL(string: Constants.baseURL + request.endpoint) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.value
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        if !request.body.isEmpty {
            let httpBodyParameters = try? JSONSerialization.data(withJSONObject: request.body, options: [])
            urlRequest.httpBody = httpBodyParameters
        }
        return urlRequest
    }
}
