//
//  HomeViewModel.swift
//  Banking
//
//  Created by Prabesh Shrestha on 05/02/2025.
//

import Foundation
import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var user: UserModel? = nil
    @Published var account: AccountModel? = nil

    let userManager: UserProtocol
    let accountManager: AccountProtocol

    init(userManager: UserProtocol, accountManager: AccountProtocol) {
        self.userManager = userManager
        self.accountManager = accountManager
    }
    let column = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var salute: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: Date())

        if let hour = components.hour{
            if hour < 12 {
                return "Good Morning"
            }
            else if hour >= 12 && hour < 16 {
                return "Good Afternoon"
            }else{
                return "Good Evening"
            }
        }
        
        return "Good Day"
    }
    func getCountryCurrency(from countryName: String) -> String {
        // Loop through all region codes
        for regionCode in Locale.isoRegionCodes {
            if let regionName = Locale.current.localizedString(forRegionCode: regionCode),
               regionName.lowercased() == countryName.lowercased() {
                let currencyCode = Locale(identifier: "en_\(regionCode)").currencyCode ?? "N/A"
                return currencyCode
            }
        }
        return "$"
    }
    
    
    func getUsers(userId: String) {
        Task {
            do {
                self.user = try await userManager.getUser(userId: userId)
            } catch {
                print("Error fetching user: \(error.localizedDescription)")
            }
        }
    }

    
    func saveUser(userId: String){
        Task{
            let formatter = DateFormatter()
            let dateString = "2002-03-14"
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: dateString) {
                try await userManager.createNewUser(user: UserModel(userId: userId, firstName: "prabesh", middleName: nil, lastName: "shrestha", dateOfBirth: date, email: "vc77it31@vedascollege.edu.np", citizenshipNo: "28017500760", isVerified: true, profilePic: nil, phoneNo: "9860184558"))            }
            
        }
    }
    
    func getAccount(userId: String){
        Task{
            account = try await accountManager.getAccountWithUserId(userId: userId)
            
        }
    }
}
