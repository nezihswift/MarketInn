//
//  ForgotPasswordViewModel.swift
//  MarketInn
//
//  Created by Nezih on 24.03.2023.
//

import Foundation

class ForgotPasswordViewModel {
    @Published private (set) var email : String? = nil
    @Published private (set) var error : Error? = nil
    
    func resetPasswordWithEmail(email: String){
        AuthenticationHandler.resetPasswordWithEmail(Email: email) { result in
            switch result {
            case .success(_):
                self.email = email
            case .failure(let error):
                self.error = error
            }
        }
    }
}
