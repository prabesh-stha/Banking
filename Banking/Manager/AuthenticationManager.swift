//
//  AuthenticationManager.swift
//  Banking
//
//  Created by Prabesh Shrestha on 06/02/2025.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager: AuthenticationProtocol{
    
    func saveToKeychain(email: String, password: String) {
//        guard let user = getUser() else { return }
        let credentials = "\(email):\(password)"
                let data = credentials.data(using: .utf8)!

                let query: [String: Any] = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrAccount as String: "firebase_login",
                    kSecValueData as String: data
                ]

                SecItemDelete(query as CFDictionary) // Delete old entry
                SecItemAdd(query as CFDictionary, nil)
    }
    
    func loadFromKeychain() -> (email: String, password: String)? {
//        guard let user = getUser() else { return nil}
        let query: [String: Any] = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrAccount as String: "firebase_login",
                    kSecReturnData as String: true,
                    kSecMatchLimit as String: kSecMatchLimitOne
                ]

                var dataTypeRef: AnyObject?
                if SecItemCopyMatching(query as CFDictionary, &dataTypeRef) == noErr {
                    if let data = dataTypeRef as? Data,
                       let credentials = String(data: data, encoding: .utf8) {
                        let parts = credentials.split(separator: ":")
                        if parts.count == 2 {
                            return (String(parts[0]), String(parts[1]))
                        }
                    }
                }
                return nil
    }
    
    func sendEmailVerification() async throws {
        guard let user = getUser() else { return }
        try await user.sendEmailVerification()
    }
    
    func resendEmailVerification() async throws {
        guard let user = getUser() else { return }
        try await user.sendEmailVerification()
    }
    
    func isEmailVerified() async throws -> Bool {
        guard let user = getUser() else { return false }
        try await user.reload()
        return user.isEmailVerified
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func signIn(email: String, password: String) async throws -> AuthDataResult {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signUp(email: String, password: String) async throws -> AuthDataResult {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func getUser() -> User? {
        let user = Auth.auth().currentUser
        
        if let user = user{
            return user
        }else{
            return nil
        }
    }
    
    
    
    
}
