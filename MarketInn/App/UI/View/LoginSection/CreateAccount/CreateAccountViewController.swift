//
//  CreateAccountViewController.swift
//  MarketInn
//
//  Created by Nezih on 16.03.2023.
//

import Foundation
import UIKit
import FirebaseAuth
import Combine

class CreateAccountViewController : UIViewController {
    private let viewModel = CreateAccountViewModel()
    private var cancellables : Set<AnyCancellable> = []
    
    private var mainView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var emailTextField : UITextField = {
        let tf = UITextField()
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.placeholder = "createaccount.emailtext".localized()
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private var passwordTextFieldOne : UITextField = {
        let tf = UITextField()
        tf.placeholder = "createaccount.passwordtext".localized()
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private var passwordTextFieldTwo : UITextField = {
        let tf = UITextField()
        tf.placeholder = "createaccount.repeatpasswordtext".localized()
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private var registerButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.theme.accent
        button.layer.cornerRadius = Constants.CornerRadius.buttonWithTen
        button.setTitle("createaccount.registerbutton".localized(), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupListeners()
        setView()
        registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        navigationItem.title = "createaccount.title".localized()
    }
    
    private func setupListeners() {
        viewModel.$user
            .receive(on: RunLoop.main)
            .sink { [weak self] user in
                guard let user = user else {
                    return
                }
                // TODO: Register User Case
                print("User Registered \nEmail: \(user.user.email)\n\n")
            }
            .store(in: &cancellables)
        viewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                print("\nError accured: \(error?.localizedDescription)\n")
                // TODO: Login Error case
            }.store(in: &cancellables)
    }
    
    @objc func registerButtonClicked(_ sender: AnyObject?) {
        guard let email = emailTextField.text,
              email.isEmailValid(),
              let password = passwordTextFieldOne.text,
              !password.isEmpty else {
            // TODO: Create Email/Password is not valid case
            return
        }
        guard passwordTextFieldTwo.text == passwordTextFieldOne.text else {
            // TODO: Create Passwords do not match case
            return
        }
        viewModel.registerWithEmailResponse(email: email, password: password)
    }
    
    private func setView() {
        view.addSubview(mainView)
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainView.autoPinEdge(toSuperviewSafeArea: .left)
        mainView.autoPinEdge(toSuperviewSafeArea: .right)
        
        mainView.addSubview(emailTextField)
        mainView.addSubview(passwordTextFieldOne)
        mainView.addSubview(passwordTextFieldTwo)
        mainView.addSubview(registerButton)
        
        emailTextField.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.Paddings.thirty)
        emailTextField.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.thirty)
        passwordTextFieldOne.autoPinEdge(.top, to: .bottom, of: emailTextField, withOffset: Constants.Paddings.fifteen)
        passwordTextFieldOne.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.Paddings.thirty)
        passwordTextFieldOne.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.thirty)
        passwordTextFieldTwo.autoPinEdge(.top, to: .bottom, of: passwordTextFieldOne, withOffset: Constants.Paddings.fifteen)
        passwordTextFieldTwo.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.Paddings.thirty)
        passwordTextFieldTwo.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.thirty)
        registerButton.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.Paddings.thirty)
        registerButton.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.thirty)
        registerButton.autoPinEdge(.top, to: .bottom, of: passwordTextFieldTwo, withOffset: Constants.Paddings.fifteen)
        
        mainView.autoPinEdge(.top, to: .top, of: emailTextField, withOffset: -Constants.Paddings.fifteen)
        mainView.autoPinEdge(.bottom, to: .bottom, of: registerButton, withOffset: Constants.Paddings.fifteen)
    }
}
