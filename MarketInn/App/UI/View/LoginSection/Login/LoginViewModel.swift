//
//  LoginViewModel.swift
//  MarketInn
//
//  Created by Nezih on 16.03.2023.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    @Published private (set) var user : AuthDataResult? = nil
    @Published private (set) var error : Error? = nil
    
    func signInWithEmailResponse(email: String, password: String){
        AuthenticationHandler.signInWithEmail(Email: email, Password: password) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                self.error = error
            }
        }
    }
}
