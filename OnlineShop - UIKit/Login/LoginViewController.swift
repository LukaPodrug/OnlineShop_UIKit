//
//  LoginViewController.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 17.01.2024..
//

import UIKit
import Combine
import SnapKit

class LoginViewController: UIViewController {
    let loginViewModel: LoginViewModel
    let loginView: LoginView
    var cancellables: Set<AnyCancellable>
    
    var confirmButtonEnabled: Bool {
        didSet {
            updateConfirmButtonEnabled(enabled: confirmButtonEnabled)
        }
    }
    
    init() {
        self.loginViewModel = LoginViewModel()
        self.loginView = LoginView()
        self.cancellables = Set<AnyCancellable>()
        
        self.confirmButtonEnabled = false
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeLoggedInViewControllers()
        setupUI()
        setupUIFunctionality()
    }
    
    func removeLoggedInViewControllers() {
        if navigationController?.viewControllers.count == 2 {
            navigationController?.viewControllers.remove(at: 0)
            return
        }
    }
    
    func setupUI() {
        navigationItem.title = "Login"
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = .white
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make -> Void in
            make.leading.top.width.height.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupUIFunctionality() {
        loginViewModel.loginViewModelDelegate = self
        
        loginView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        loginView.usernameTextField.addTarget(self, action: #selector(textFieldFocus(sender:)), for: .editingDidBegin)
        loginView.usernameTextField.addTarget(self, action: #selector(textFieldUnfocus(sender:)), for: .editingDidEnd)
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: loginView.usernameTextField)
            .map { _ in self.loginView.usernameTextField.text! }
            .assign(to: \.username, on: loginViewModel)
            .store(in: &cancellables)
        
        loginView.passwordTextField.addTarget(self, action: #selector(textFieldFocus(sender:)), for: .editingDidBegin)
        loginView.passwordTextField.addTarget(self, action: #selector(textFieldUnfocus(sender:)), for: .editingDidEnd)
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: loginView.passwordTextField)
            .map { _ in self.loginView.passwordTextField.text! }
            .assign(to: \.password, on: loginViewModel)
            .store(in: &cancellables)
        
        loginView.confirmButton.addTarget(self, action: #selector(confirmButtonPress), for: .touchUpInside)
        loginViewModel.validatedCrendentials
            .assign(to: \.confirmButtonEnabled, on: self)
            .store(in: &cancellables)
    }
}

extension LoginViewController {
    @objc func hideKeyboard() {
        loginView.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        loginView.scrollView.snp.updateConstraints { make -> Void in
            make.height.equalTo(loginView).offset(-sender.getKeyboardHeightBegin() - 2 * loginView.verticalOffset)
        }
    }
    
    @objc func keyboardWillHide() {
        loginView.scrollView.snp.updateConstraints { make -> Void in
            make.height.equalTo(loginView)
        }
    }
    
    @objc func textFieldFocus(sender: CustomTextField) {
        sender.updateBackgroundColor(backgroundColor: .systemGray4)
    }
    
    @objc func textFieldUnfocus(sender: CustomTextField) {
        sender.updateBackgroundColor(backgroundColor: .systemGray5)
    }
    
    @objc func confirmButtonPress() {
        loginView.confirmButton.onButtonPressAnimation()
        resetTextFieldCursor()
        loginViewModel.login()
    }
}

extension LoginViewController {
    func updateConfirmButtonEnabled(enabled: Bool) {
        loginView.confirmButton.isEnabled = enabled
        loginView.confirmButton.updateBackgroundColor(backgroundColor: enabled == true ? .systemBlue : .systemGray4)
    }
    
    func resetTextFieldCursor() {
        loginView.usernameTextField.resignFirstResponder()
        loginView.passwordTextField.resignFirstResponder()
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func navigateToHome(userData: UserModel) {
        navigationController?.pushViewController(HomeViewController(userData: userData), animated: true)
    }
    
    func showErrorAlert(message: String) {
        let alertController: UIAlertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
