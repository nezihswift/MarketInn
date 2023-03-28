//
//  ForgotPasswordViewController.swift
//  MarketInn
//
//  Created by Nezih on 22.03.2023.
//

import Foundation
import UIKit
import Combine

class ForgotPasswordViewControler : UIViewController {
    private let viewModel = ForgotPasswordViewModel()
    private var cancellables : Set<AnyCancellable> = []
    
    private var mainView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var informationText : UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.midSmallText
        label.textAlignment = .natural
        label.backgroundColor = .clear
        label.text = "forgotpassword.informationtext".localized()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.textColor = UIColor.theme.accent
        return label
    }()
    
    private var emailTextField : UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = "forgotpassword.emailtext".localized()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private var resetButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.theme.text
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.theme.secondary, for: .normal)
        button.layer.cornerRadius = Constants.CornerRadius.buttonWithTen
        button.setTitle("forgotpassword.resetbutton".localized(), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "forgotpassword.title".localized()
        resetButton.addTarget(self, action: #selector(resetButtonClicked), for: .touchUpInside)
        setView()
        setListeners()
    }
    
    
    @objc private func resetButtonClicked(_ sender: AnyObject?) {
        guard let emailText = emailTextField.text else {
            return
        }
        viewModel.resetPasswordWithEmail(email: emailText)
    }
    
    private func setListeners() {
        viewModel.$email
            .receive(on: RunLoop.main)
            .sink { [weak self] email in
                guard let _ = email else {
                    return
                }
                let alert = UIAlertController(title: "emailsuccess.title".localized(), message:"emailsuccess.text".localized(), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "emailsuccess.button".localized(), style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
            .store(in: &cancellables)
        viewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                guard let error = error else {
                    return
                }
                let alert = UIAlertController(title: "emailerror.title".localized(), message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "emailerror.button".localized(), style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
            .store(in: &cancellables)
    }
    
    private func setView() {
        view.addSubview(mainView)
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainView.autoPinEdge(toSuperviewSafeArea: .left)
        mainView.autoPinEdge(toSuperviewSafeArea: .right)
        mainView.addSubview(informationText)
        mainView.addSubview(emailTextField)
        mainView.addSubview(resetButton)
        
        informationText.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.Paddings.thirty)
        informationText.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.thirty)
        
        emailTextField.autoPinEdge(.top, to: .bottom, of: informationText, withOffset: Constants.Paddings.fifteen)
        emailTextField.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.Paddings.thirty)
        emailTextField.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.thirty)
        
        resetButton.autoPinEdge(.top, to: .bottom, of: emailTextField, withOffset: Constants.Paddings.fifteen)
        resetButton.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.Paddings.thirty)
        resetButton.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.Paddings.thirty)
        
        mainView.autoPinEdge(.top, to: .top, of: informationText, withOffset: -Constants.Paddings.fifteen)
        mainView.autoPinEdge(.bottom, to: .bottom, of: resetButton, withOffset: Constants.Paddings.fifteen)
    }
}
