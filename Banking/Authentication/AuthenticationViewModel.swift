//
//  AuthenticationViewModel.swift
//  Banking
//
//  Created by Prabesh Shrestha on 06/02/2025.
//

import Foundation
import Security
import LocalAuthentication


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
    @Published var userEmail: String = ""
    
    func authenticateWithFaceID() async -> Bool {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            return await withCheckedContinuation { continuation in
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                       localizedReason: "Use Face ID to log in") { success, error in
                    if let error = error {
                        print("🔥 Face ID Error: \(error.localizedDescription)")
                    }
                    continuation.resume(returning: success)
                }
            }
        } else {
            print("Face ID not available: \(error?.localizedDescription ?? "Unknown error")")
            return false
        }
    }


    func loginWithFaceID() async throws{
        guard let credentials = auth.loadFromKeychain() else {
            showAlert = true
            alertMessage = "No credentials stored. Please log in manually first."
            return
        }

        let isAuthenticated = await authenticateWithFaceID()
        if isAuthenticated {
            do {
                let _ = try await auth.signIn(email: credentials.email, password: credentials.password)
                 try await checkEmailVerification()
            } catch {
                print("Firebase Login Failed: \(error.localizedDescription)")
                showAlert = true
                alertMessage = "Firebase Login Failed: \(error.localizedDescription)"
            }
        } else {
            showAlert = true
            alertMessage = "Face ID authentication failed."
        }
    }

    
    func saveCredentials() {
        if let _ = auth.loadFromKeychain() {
        }else{
            auth.saveToKeychain(email: email, password: password)
        }
      }
    
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
            let _ = try await auth.signUp(email: email, password: password)
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
