//
//  AuthenticationViewModel.swift
//  Banking
//
//  Created by Prabesh Shrestha on 06/02/2025.
//

import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject{
    private let auth: AuthenticationProtocol
    
    init(auth: AuthenticationProtocol) {
        self.auth = auth
    }
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var signup: Bool = false
    
    func sendEmailVerification() async throws{
        do{
            try await auth.sendEmailVerification()
            showAlert = true
            alertMessage = "Email verification sent"
        }catch{
            showAlert = true
            alertMessage = "Failed to send email. \(error.localizedDescription)"
        }
    }
    
    func reSendEmailVerification() async throws{
        do{
            try await auth.resendEmailVerification()
            showAlert = true
            alertMessage = "Email verification sent"
        }catch{
            showAlert = true
            alertMessage = "Failed to send email. \(error.localizedDescription)"
        }
    }
    
    func checkEmailVerification() async throws{
        do{
            let result = try await auth.isEmailVerified()
            if result{
                isLoggedIn = true
            }else{
                showAlert = true
                alertMessage = "Please verify your email before logging in."
            }
        }catch{
            showAlert = true
            alertMessage = "\(error.localizedDescription)"
        }
    }
    
    func signUp() async throws{
        do{
            let result = try await auth.signUp(email: email, password: password)
            try await sendEmailVerification()
            showAlert = true
            alertMessage = "Please verify your email and log in to enjoy the baking. 😁"
        }catch{
            showAlert = true
            alertMessage = "Sorry couldn't create account at the moment. 😔"
        }
    }
    
    func signIn() async throws{
        do{
            let _ = try await auth.signIn(email: email, password: password)
            try await checkEmailVerification()
        }catch{
            showAlert = true
            alertMessage = "Sorry couldn't logged in to your account at the moment. 😔"
        }
    }
    
}
