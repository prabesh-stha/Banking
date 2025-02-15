//
//  NewUserViewModel.swift
//  Banking
//
//  Created by Prabesh Shrestha on 08/02/2025.
//

import Foundation
import PhotosUI
import SwiftUI

@MainActor
final class NewUserViewModel: ObservableObject {
    
    /// This is the User creation section
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var firstName: String = ""
    @Published var middleName: String = ""
    @Published var lastName: String = ""
    @Published var dateOfBirth: Date = Date()
    @Published var citzenshipNo: String = ""
    @Published var profilePic: String = ""
    @Published var showPassword: Bool = false
    
    @Published var selectedUserItem: PhotosPickerItem?
    @Published var selectedUserImage: Image?
    
    /// This is the account creation section
    @Published var accountNo: Int = 0
    @Published var country: String = ""
    @Published var accountType: String = ""
    @Published var amount: Double = 0.0
    @Published var pin: Int = 0
    
    /// This is the alert section
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    /// This is for the manager section
    private let authManager: AuthenticationProtocol
    private let userManager: UserProtocol
    
    init(authManager: AuthenticationProtocol, userManager: UserProtocol) {
        self.authManager = authManager
        self.userManager = userManager
    }
    
//    func createNewUser() async throws {
//        do{
//            let authDataResult = try await authManager.signUp(email: email, password: password)
//            let user = UserModel(userId: authDataResult.user.uid, firstName: firstName, middleName: middleName, lastName: lastName, dateOfBirth: dateOfBirth, email: authDataResult.user.email ?? email, citizenshipNo: citzenshipNo, isVerified: false, profilePic: profilePic)
//            let account = AccountModel(accountNo: accountNo, country: country, accountType: accountType, amount: amount, pin: pin)
//            
//            try await userManager.createNewUser(user: user)
//            try await userManager.createAccount(userId: authDataResult.user.uid, account: account)
//        }catch{
//            showAlert = true
//            alertMessage = "Couldn't create an user at the moment. 😔"
//        }
        
//    }
}
