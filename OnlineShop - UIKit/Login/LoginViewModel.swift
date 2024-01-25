//
//  LoginViewModel.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 17.01.2024..
//

import Foundation
import Combine

protocol LoginViewModelDelegate: AnyObject {
    func navigateToHome(userData: UserModel)
    func showErrorAlert(message: String)
}

class LoginViewModel: ObservableObject {
    var loginViewModelDelegate: LoginViewModelDelegate?
    
    var cancellables: Set<AnyCancellable>
    
    @Published var username: String
    @Published var password: String
    
    init() {
        self.cancellables = Set<AnyCancellable>()
        
        self.username = ""
        self.password = ""
    }
}

extension LoginViewModel {
    func login() {
        APIManager.shared.login(username: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        self.handleLoginFailure(message: error.localizedDescription)
                    default:
                        break
                }
            }
            receiveValue: { userData in
                self.handleLoginSuccess(userData: userData)
            }
            .store(in: &cancellables)
    }
    
    func handleLoginFailure(message: String) {
        loginViewModelDelegate?.showErrorAlert(message: message)
    }
    
    func handleLoginSuccess(userData: UserModel) {
        saveToken(userData: userData)
    }
}

extension LoginViewModel {
    func saveToken(userData: UserModel) {
        KeychainManager.shared.save(type: kSecClassGenericPassword, service: "token", account: "user", data: userData.token.data(using: .utf8)!) { result in
            switch result {
                case .failure(let error):
                    self.handleSaveTokenFailure(message: error.localizedDescription)
                case .success:
                    self.handleSaveTokenSuccess(userData: userData)
            }
        }
    }
    
    func handleSaveTokenFailure(message: String) {
        loginViewModelDelegate?.showErrorAlert(message: message)
    }
    
    func handleSaveTokenSuccess(userData: UserModel) {
        loginViewModelDelegate?.navigateToHome(userData: userData)
    }
}

extension LoginViewModel {
    var validatedUsername: AnyPublisher<Bool, Never> {
        return $username
            .map { username in
                if username.count == 0 {
                    return false
                }
                
                return true
            }
            .eraseToAnyPublisher()
    }
    
    var validatedPassword: AnyPublisher<Bool, Never> {
        return $password
            .map { password in
                if password.count == 0 {
                    return false
                }
                
                return true
            }
            .eraseToAnyPublisher()
    }
    
    var validatedCrendentials: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(validatedUsername, validatedPassword)
            .receive(on: DispatchQueue.main)
            .map { username, password in
                if username == false || password == false {
                    return false
                }
                
                return true
            }
            .eraseToAnyPublisher()
    }
}
