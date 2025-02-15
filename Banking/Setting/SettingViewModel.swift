//
//  SettingViewModel.swift
//  Banking
//
//  Created by Prabesh Shrestha on 07/02/2025.
//

import Foundation

@MainActor
final class SettingViewModel: ObservableObject{
    private let auth: AuthenticationManager
    private let account: AccountManager
    init(auth: AuthenticationManager, account: AccountManager) {
        self.auth = auth
        self.account = account
    }
    
    @Published var userAccount: AccountModel? = nil
    
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isSuccessful: Bool = false
    @Published var showPinChange: Bool = false
    
    
    func signOut() throws{
        do{
            try auth.signOut()
            showAlert = true
            alertMessage = "Signout Successfully."
            isSuccessful = true
        }catch{
            showAlert = true
            alertMessage = "Couldn't signout at the moment."
            isSuccessful = false
        }
    }
    
    func getAccount(userId: String) async throws{
        self.userAccount = try await account.getAccountWithUserId(userId: userId)
    }
    
    
}
