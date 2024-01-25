//
//  APIManager.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 17.01.2024..
//

import Foundation
import Combine

enum APIError: Error {
    case invalidURL
    case missingResponse
    case user
    case server
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return NSLocalizedString("Invalid URL", comment: "")
            case .missingResponse:
                return NSLocalizedString("Missing response", comment: "")
            case .user:
                return NSLocalizedString("User error", comment: "")
            case .server:
                return NSLocalizedString("Server error", comment: "")
            case .unknown:
                return NSLocalizedString("Unknown error", comment: "")
        }
    }
}

class APIManager {
    static let shared: APIManager = APIManager()
    var cancellables = Set<AnyCancellable>()
    
    let baseAPIURL: String = "https://dummyjson.com"
    
    func login(username: String, password: String) -> Future<UserModel, Error> {
        let fullAPIURL: String = baseAPIURL + "/auth" + "/login"
        
        return Future<UserModel, Error> { promise in
            guard let url = URL(string: fullAPIURL) else {
                return promise(.failure(APIError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let bodyDictionary: [String: Any] = ["username": username, "password": password]
            let bodyJSON = try? JSONSerialization.data(withJSONObject: bodyDictionary)
            
            request.httpBody = bodyJSON
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw APIError.missingResponse
                    }
                    
                    if 400...499 ~= httpResponse.statusCode {
                        throw APIError.user
                    }
                    
                    else if 500...599 ~= httpResponse.statusCode {
                        throw APIError.server
                    }
                    
                    else if !(200...299 ~= httpResponse.statusCode) {
                        throw APIError.unknown
                    }
                    
                    return data
                }
                .decode(type: UserModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                            case let decodingError as DecodingError:
                                promise(.failure(decodingError))
                            case let apiError as APIError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(APIError.unknown))
                        }
                    }
                }, receiveValue: { data in
                    promise(.success(data))
                })
                .store(in: &self.cancellables)
        }
    }
    
    func getUserCart(userId: Int) -> Future<GetCartModel, Error> {
        let fullAPIURL: String = baseAPIURL + "/carts" + "/user" + "/\(userId)"
        
        return Future<GetCartModel, Error> { promise in
            guard let url = URL(string: fullAPIURL) else {
                return promise(.failure(APIError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw APIError.missingResponse
                    }
                    
                    if 400...499 ~= httpResponse.statusCode {
                        throw APIError.user
                    }
                    
                    else if 500...599 ~= httpResponse.statusCode {
                        throw APIError.server
                    }
                    
                    else if !(200...299 ~= httpResponse.statusCode) {
                        throw APIError.unknown
                    }
                    
                    return data
                }
                .decode(type: GetCartModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                            case let decodingError as DecodingError:
                                promise(.failure(decodingError))
                            case let apiError as APIError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(APIError.unknown))
                        }
                    }
                }, receiveValue: { data in
                    promise(.success(data))
                })
                .store(in: &self.cancellables)
        }
    }
    
    func getProductsCategories() -> Future<[String], Error> {
        let fullAPIURL: String = baseAPIURL + "/products" + "/categories"
        
        return Future<[String], Error> { promise in
            guard let url = URL(string: fullAPIURL) else {
                return promise(.failure(APIError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw APIError.missingResponse
                    }
                    
                    if 400...499 ~= httpResponse.statusCode {
                        throw APIError.user
                    }
                    
                    else if 500...599 ~= httpResponse.statusCode {
                        throw APIError.server
                    }
                    
                    else if !(200...299 ~= httpResponse.statusCode) {
                        throw APIError.unknown
                    }
                    
                    return data
                }
                .decode(type: [String].self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                            case let decodingError as DecodingError:
                                promise(.failure(decodingError))
                            case let apiError as APIError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(APIError.unknown))
                        }
                    }
                }, receiveValue: { data in
                    promise(.success(data))
                })
                .store(in: &self.cancellables)
        }
    }
    
    func getCategoryProducts(categoryName: String) -> Future<GetProductsModel, Error> {
        let fullAPIURL: String = baseAPIURL + "/products" + "/category" + "/\(categoryName)"
        
        return Future<GetProductsModel, Error> { promise in
            guard let url = URL(string: fullAPIURL) else {
                return promise(.failure(APIError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw APIError.missingResponse
                    }
                    
                    if 400...499 ~= httpResponse.statusCode {
                        throw APIError.user
                    }
                    
                    else if 500...599 ~= httpResponse.statusCode {
                        throw APIError.server
                    }
                    
                    else if !(200...299 ~= httpResponse.statusCode) {
                        throw APIError.unknown
                    }
                    
                    return data
                }
                .decode(type: GetProductsModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                            case let decodingError as DecodingError:
                                promise(.failure(decodingError))
                            case let apiError as APIError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(APIError.unknown))
                        }
                    }
                }, receiveValue: { data in
                    promise(.success(data))
                })
                .store(in: &self.cancellables)
        }
    }
    
    func updateUserCart(cartId: Int, productId: Int, productQuantity: Int) -> Future<CartModel, Error> {
        let fullAPIURL: String = baseAPIURL + "/carts" + "/\(cartId)"
        
        return Future<CartModel, Error> { promise in
            guard let url = URL(string: fullAPIURL) else {
                return promise(.failure(APIError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            
            let productDictionary: [String : Any] = ["id": productId, "quantity": productQuantity]
            let bodyDictionary: [String: Any] = ["merge": true, "products": [productDictionary]]
            let bodyJSON = try? JSONSerialization.data(withJSONObject: bodyDictionary)
            
            request.httpBody = bodyJSON
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw APIError.missingResponse
                    }
                    
                    if 400...499 ~= httpResponse.statusCode {
                        throw APIError.user
                    }
                    
                    else if 500...599 ~= httpResponse.statusCode {
                        throw APIError.server
                    }
                    
                    else if !(200...299 ~= httpResponse.statusCode) {
                        throw APIError.unknown
                    }
                    
                    return data
                }
                .decode(type: CartModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                            case let decodingError as DecodingError:
                                promise(.failure(decodingError))
                            case let apiError as APIError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(APIError.unknown))
                        }
                    }
                }, receiveValue: { data in
                    promise(.success(data))
                })
                .store(in: &self.cancellables)
        }
    }
    
    func getAllProducts(limit: Int, skip: Int) -> Future<GetProductsModel, Error> {
        let fullAPIURL: String = baseAPIURL + "/products" + "?" + "limit=\(limit)" + "&" + "skip=\(skip)"
        
        return Future<GetProductsModel, Error> { promise in
            guard let url = URL(string: fullAPIURL) else {
                return promise(.failure(APIError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw APIError.missingResponse
                    }
                    
                    if 400...499 ~= httpResponse.statusCode {
                        throw APIError.user
                    }
                    
                    else if 500...599 ~= httpResponse.statusCode {
                        throw APIError.server
                    }
                    
                    else if !(200...299 ~= httpResponse.statusCode) {
                        throw APIError.unknown
                    }
                    
                    return data
                }
                .decode(type: GetProductsModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                            case let decodingError as DecodingError:
                                promise(.failure(decodingError))
                            case let apiError as APIError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(APIError.unknown))
                        }
                    }
                }, receiveValue: { data in
                    promise(.success(data))
                })
                .store(in: &self.cancellables)
        }
    }
    
    func getSearchedProducts(searchString: String) -> Future<GetProductsModel, Error> {
        let fullAPIURL: String = baseAPIURL + "/products" + "/search" + "?q=" + "\(searchString)"
        
        return Future<GetProductsModel, Error> { promise in
            guard let url = URL(string: fullAPIURL) else {
                return promise(.failure(APIError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw APIError.missingResponse
                    }
                    
                    if 400...499 ~= httpResponse.statusCode {
                        throw APIError.user
                    }
                    
                    else if 500...599 ~= httpResponse.statusCode {
                        throw APIError.server
                    }
                    
                    else if !(200...299 ~= httpResponse.statusCode) {
                        throw APIError.unknown
                    }
                    
                    return data
                }
                .decode(type: GetProductsModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                            case let decodingError as DecodingError:
                                promise(.failure(decodingError))
                            case let apiError as APIError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(APIError.unknown))
                        }
                    }
                }, receiveValue: { data in
                    promise(.success(data))
                })
                .store(in: &self.cancellables)
        }
    }
}
