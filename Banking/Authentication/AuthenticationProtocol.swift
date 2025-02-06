//
//  AuthenticationProtocol.swift
//  Banking
//
//  Created by Prabesh Shrestha on 06/02/2025.
//

import Foundation
import FirebaseAuth

protocol AuthenticationProtocol{
    
    func signOut() throws
    
    func signIn(email: String, password: String) async throws -> AuthDataResult
    
    func signUp(email: String, password: String) async throws -> AuthDataResult
    
    func getUser() -> User?
    
    func sendEmailVerification() async throws
    
    func resendEmailVerification() async throws
    
    func isEmailVerified() async throws -> Bool
    
    
    
    
}
