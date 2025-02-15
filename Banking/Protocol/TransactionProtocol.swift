//
//  TransactionProtocol.swift
//  Banking
//
//  Created by Prabesh Shrestha on 11/02/2025.
//

import Foundation

protocol TransactionProtocol{
    
    func createTransaction(transaction: TransactionModel) async throws
    
    func getTransactions(userId: String) async throws -> [TransactionModel]
    
    func transferMoney(from senderAccountNumber: String, to recipientAccountNumber: String, amount: Double) async throws -> Bool
    
}
