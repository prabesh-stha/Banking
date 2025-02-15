//
//  ChangePinViewModel.swift
//  Banking
//
//  Created by Prabesh Shrestha on 12/02/2025.
//

import Foundation

@MainActor
final class ChangePinViewModel: ObservableObject{
    let account: AccountProtocol
    
    init(account: AccountProtocol) {
        self.account = account
    }
    
    @Published var currentPIN: [String] = Array(repeating: "", count: 4)
        @Published var newPIN: [String] = Array(repeating: "", count: 4)
        @Published var confirmPIN: [String] = Array(repeating: "", count: 4)

        @Published var errorMessage: String?
    @Published var showMessage: Bool = false
    @Published var message: String = ""

        var isCurrentPinComplete: Bool {
            !currentPIN.contains("")
        }

        var isNewPinComplete: Bool {
            !newPIN.contains("")
        }

        var isConfirmPinComplete: Bool {
            !confirmPIN.contains("")
        }

        func validatePIN() -> Bool {
            let newPinString = newPIN.joined()
            let confirmPinString = confirmPIN.joined()

            if !isCurrentPinComplete || !isNewPinComplete || !isConfirmPinComplete {
                errorMessage = "All PIN fields must be 4 digits."
                return false
            }
            if newPinString != confirmPinString {
                errorMessage = "New PIN and Confirm PIN do not match."
                return false
            }
            errorMessage = nil
            return true
        }
    
    func changePin(accountNo: String) async throws {
        guard validatePIN() else {
            return
        }
        
        do{
            try await account.changePin(accountNo: accountNo, currentPin: currentPIN.joined(), newPin: newPIN.joined())
            showMessage = true
            message = "PIN changed successfully"
        }catch{
            print(error.localizedDescription)
        }
    }
}
