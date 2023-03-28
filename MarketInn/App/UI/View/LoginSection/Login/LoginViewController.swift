//
//  ViewController.swift
//  MarketInn
//
//  Created by Nezih on 9.03.2023.
//

import UIKit
import PureLayout
import FirebaseAuth
import Combine

class LoginViewController: UIViewController {
    private let viewModel = LoginViewModel()
    private var cancellables : Set<AnyCancellable> = []
    
    private let logoView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var loginView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var idTextField : UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = "login.idtext".localized()
        textField.borderStyle = .roundedRect
        //textField.backgroundColor = UIColor.theme.secondary
        return textField
    }()
    
    private var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "login.passwordtext".localized()
        //textField.backgroundColor = UIColor.theme.secondary
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private var resetPasswordLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        label.text = "login.resetpasswordtext".localized()
        label.font = Constants.Fonts.smallText
        label.textColor = UIColor.theme.text
        return label
    }()
    
    let leftLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.theme.text
        return view
    }()
    
    let rightLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.theme.text
        return view
    }()
    
    private var orLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.smallText
        label.text = "OR"
        return label
    }()
    
    private var loginButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.theme.text
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.theme.secondary, for: .normal)
        button.layer.cornerRadius = Constants.CornerRadius.buttonWithTen
        button.setTitle("login.logintext".localized(), for: .normal)
        return button
    }()
    
    private var createAccountButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.theme.text
        button.setTitleColor(UIColor.theme.secondary, for: .normal)
        button.layer.cornerRadius = Constants.CornerRadius.buttonWithTen
        button.setTitle("login.createaccounttext".localized(), for: .normal)
        return button
    }()
    
    private var errorLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.errorTextColor
        label.textAlignment = .center
        label.numberOfLines = 5
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.theme.secondary
        setView()
        setListeners()
        setButtons()
        navigationItem.title = "login.title".localized()
    }
    
    private func setButtons() {
        let resetPasswordTap = UITapGestureRecognizer(target: self, action: #selector(resetPasswordClicked))
        resetPasswordLabel.addGestureRecognizer(resetPasswordTap)
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonClicked), for: .touchUpInside)
    }
    
    @objc func resetPasswordClicked(_ sender: AnyObject?) {
        guard let viewController = storyboard!.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewControler,
              let navigationController = navigationController else {
            return
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    @objc func createAccountButtonClicked(_ sender: AnyObject?) {
        guard let viewController = storyboard!.instantiateViewController(withIdentifier: "CreateAccountViewController") as? CreateAccountViewController,
              let navigationController = navigationController else {
            return
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    @objc func loginButtonClicked(_ sender: AnyObject?) {
        guard let email = idTextField.text,
              email.isEmailValid() else {
            errorLabel.text = "login.invalidemail".localized()
            return
        }
        guard let password = passwordTextField.text,
              !password.isEmpty else {
            errorLabel.text = "login.passwordempty".localized()
            return
        }
        viewModel.signInWithEmailResponse(email: email, password: password)
    }
    
    private func setListeners() {
        viewModel.$user
            .receive(on: RunLoop.main)
            .sink { [weak self] user in
                // TODO: Login User
            }
            .store(in: &cancellables)
        viewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                self?.errorLabel.text = error?.localizedDescription
                // TODO: Login Error case
            }.store(in: &cancellables)
    }
    
    private func setView() {
        view.addSubview(loginView)
        loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginView.autoPinEdge(toSuperviewSafeArea: .left)
        loginView.autoPinEdge(toSuperviewSafeArea: .right)
        loginView.addSubview(idTextField)
        loginView.addSubview(passwordTextField)
        loginView.addSubview(loginButton)
        loginView.addSubview(createAccountButton)
        loginView.addSubview(orLabel)
        idTextField.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.Paddings.thirty)
        idTextField.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.thirty)
        passwordTextField.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.Paddings.thirty)
        passwordTextField.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.thirty)
        passwordTextField.autoPinEdge(.top, to: .bottom, of: idTextField, withOffset: Constants.Paddings.fifteen)
        
        loginView.addSubview(resetPasswordLabel)
        resetPasswordLabel.autoPinEdge(.top, to: .bottom, of: passwordTextField, withOffset: Constants.Paddings.five)
        resetPasswordLabel.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.thirty)

        loginButton.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.thirty)
        loginButton.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.Paddings.thirty)
        loginButton.autoPinEdge(.top, to: .bottom, of: resetPasswordLabel, withOffset: Constants.Paddings.ten)
        
        
        orLabel.autoPinEdge(.top, to: .bottom, of: loginButton, withOffset: Constants.Paddings.ten)
        orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        createAccountButton.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.Paddings.thirty)
        createAccountButton.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.thirty)
        createAccountButton.autoPinEdge(.top, to: .bottom, of: orLabel, withOffset: Constants.Paddings.ten)
        
        loginView.addSubview(leftLine)
        loginView.addSubview(rightLine)
        
        leftLine.autoPinEdge(.top, to: .bottom, of: loginButton, withOffset: 17.5)
        leftLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        leftLine.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.Paddings.fifty)
        leftLine.autoPinEdge(.right, to: .left, of: orLabel,withOffset: -Constants.Paddings.ten)
        
        rightLine.autoPinEdge(.top, to: .bottom, of: loginButton, withOffset: 17.5)
        rightLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        rightLine.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.fifty)
        rightLine.autoPinEdge(.left, to: .right, of: orLabel, withOffset: Constants.Paddings.ten)
        
        
        loginView.autoPinEdge(.top, to: .top, of: idTextField, withOffset: -Constants.Paddings.fifteen)
        loginView.autoPinEdge(.bottom, to: .bottom, of: createAccountButton, withOffset: Constants.Paddings.fifteen)
        
        
        
        view.addSubview(errorLabel)
        errorLabel.autoPinEdge(.top, to: .bottom, of: loginView, withOffset: Constants.Paddings.fifteen)
        errorLabel.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.Paddings.fifteen)
        errorLabel.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.fifteen)

        

        
        
        

        
        view.addSubview(logoView)
        logoView.autoPinEdge(.bottom, to: .top, of: loginView, withOffset: -Constants.Paddings.fifteen*3)
        logoView.autoPinEdge(toSuperviewSafeArea: .top, withInset: Constants.Paddings.fifteen)
        //logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //logoView.widthAnchor.constraint(equalToConstant: logoView.frame.size.height).isActive = true
    }


}

