//
//  TransferMoneyViewModel.swift
//  Banking
//
//  Created by Prabesh Shrestha on 12/02/2025.
//

import Foundation

@MainActor
final class TransferMoneyViewModel: ObservableObject{
    
    
    
    @Published var showPinSheet: Bool = false
    @Published var accountNumber: String = "" {
        didSet {
            errorMessage = nil

            if accountNumber.count == 16 {
                errorMessage = nil
                getRecipientAccount()
            } else {
                errorMessage = "Account Number must contain 16 digits"
            }
        }
    }

    @Published var receiverName: String = ""
    @Published var receiverNumber: String = ""
    @Published var amount: String = "" {
        didSet{
            amountDouble = Double(amount) ?? 0
        }
    }
    @Published var pin: [String] = Array(repeating: "", count: 4)
    var isPinComplete: Bool {
        !pin.contains("")
    }
    var amountDouble: Double
    
    @Published var errorMessage: String? = nil
    
    let account: AccountProtocol
    let transaction: TransactionProtocol
    let user: UserProtocol
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    init(account: AccountProtocol, transaction: TransactionProtocol, user: UserProtocol) {
        self.account = account
        self.transaction = transaction
        self.user = user
        self.amountDouble = 0
    }
    
    func transerMoney(userId: String) async throws {
        guard let user = try await account.getAccountWithUserId(userId: userId) else{
            showAlert = true
            alertMessage = "No account found."
            throw NSError(domain: "No account found.", code: 0, userInfo: nil)
        }
        let result = try await account.validatePin(accountNo: user.accountNo, pin: pin.joined())
        if result{
            if try await transaction.transferMoney(from: user.accountNo, to: accountNumber, amount: amountDouble){
                showAlert = true
                alertMessage = "Successfully transfered \(Utility.formattedAmount(amount: amountDouble)) to \(accountNumber)."
            }else{
                showAlert = true
                alertMessage = "Something went wrong. Please try again later."
            }
            
        }else{
            showAlert = true
            alertMessage = "Invalid Pin"
        }
    }
    
    
    func getRecipientAccount() {
        guard accountNumber.count == 16 else { return }
        
        Task {
            do {
                let recipient = try await account.getAccount(accountNo: accountNumber)
                let recipientUser = try await user.getUser(userId: recipient.userId)
                
                DispatchQueue.main.async {
                    if let middleName = recipientUser.middleName {
                        self.receiverName = "\(recipientUser.firstName) \(middleName) \(recipientUser.lastName)"
                    } else {
                        self.receiverName = "\(recipientUser.firstName) \(recipientUser.lastName)"
                    }
                    self.receiverNumber = recipientUser.phoneNo
                    self.errorMessage = nil
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Account not valid."
                    self.receiverName = ""
                    self.receiverNumber = ""
                }
            }
        }
    }
}
