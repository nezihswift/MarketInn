//
//  HomeViewController.swift
//  MarketInn
//
//  Created by Nezih on 28.03.2023.
//

import Foundation
import UIKit

class HomeViewController : UIViewController {
    
    let loginButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.theme.accent, for: .normal)
        button.layer.cornerRadius = Constants.CornerRadius.buttonWithTen
        button.setTitle("main.loginbutton".localized(), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    @objc private func loginButtonPressed(_ sender: AnyObject?){
        guard let viewController = storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController,
              let navigationController = navigationController else {
            return
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView:loginButton)
    }
}
