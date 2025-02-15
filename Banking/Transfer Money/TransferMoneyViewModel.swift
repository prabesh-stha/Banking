//
//  TransferMoneyViewModel.swift
//  Banking
//
//  Created by Prabesh Shrestha on 12/02/2025.
//

import Foundation

@MainActor
final class TransferMoneyViewModel: ObservableObject{
    @Published var accountNumber: String = ""
    @Published var receiverName: String = ""
    @Published var amount: String = ""
    @Published var pin: String = ""
    
    let account: AccountProtocol
    let transaction: TransactionProtocol
    let user: UserProtocol
    
    init(account: AccountProtocol, transaction: TransactionProtocol, user: UserProtocol) {
        self.account = account
        self.transaction = transaction
        self.user = user
    }
    
    
}
