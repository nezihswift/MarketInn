//
//  AuthenticationHandler.swift
//  MarketInn
//
//  Created by Nezih on 16.03.2023.
//

import Foundation
import UIKit
import FirebaseAuth

final class AuthenticationHandler {
    typealias signInWithEmailResponse = ((Swift.Result<AuthDataResult, Error>) -> Void)
    typealias registerWithEmailResponse = ((Swift.Result<AuthDataResult, Error>) -> Void)
    
    static func signInWithEmail(Email email: String, Password password: String, completion: @escaping signInWithEmailResponse) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                completion(.failure(error!))
            } else {
                guard let result = result else {
                    return
                }
                completion(.success(result))
            }
        }
    }
    
    static func registerWithEmail(Email email: String, Password password: String, completion: @escaping registerWithEmailResponse) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                completion(.failure(error!))
            } else {
                guard let result = result else {
                    return
                }
                completion(.success(result))
            }
        }
    }
}
