//
//  LoginView.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 17.01.2024..
//

import UIKit
import SnapKit

class LoginView: UIView {
    let verticalOffset: CGFloat = 5
    let horizontalOffset: CGFloat = 5
    let labelHeight: CGFloat = 12
    let textFieldHeight: CGFloat = 50
    let buttonHeight: CGFloat = 50
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Username"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let usernameTextField: CustomTextField = {
        let textField = CustomTextField()
        
        textField.font = textField.font?.withSize(15)
        textField.backgroundColor = .systemGray5
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        
        return textField
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Password"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        
        textField.isSecureTextEntry = true
        textField.font = textField.font?.withSize(15)
        textField.backgroundColor = .systemGray5
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        
        return textField
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Confirm", for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func draw(_ rect: CGRect) {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.bottom.equalToSuperview().offset(-verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.greaterThanOrEqualToSuperview().offset(-2 * verticalOffset)
            make.height.equalTo(10 * verticalOffset + 2 * labelHeight + 2 * textFieldHeight + buttonHeight)
        }
        
        contentView.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(2 * horizontalOffset)
            make.top.equalToSuperview().offset(verticalOffset)
            make.width.equalToSuperview().offset(-4 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        contentView.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(usernameLabel.snp.bottom).offset(verticalOffset / 2)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(textFieldHeight)
        }
        
        contentView.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(2 * horizontalOffset)
            make.top.equalTo(usernameTextField.snp.bottom).offset(2 * verticalOffset)
            make.width.equalToSuperview().offset(-4 * horizontalOffset)
            make.height.equalTo(labelHeight)
        }
        
        contentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(passwordLabel.snp.bottom).offset(verticalOffset / 2)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(textFieldHeight)
        }
        
        contentView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.top.equalTo(passwordTextField.snp.bottom).offset(4 * verticalOffset)
            make.width.equalToSuperview().offset(-2 * horizontalOffset)
            make.height.equalTo(buttonHeight)
        }
    }
}
