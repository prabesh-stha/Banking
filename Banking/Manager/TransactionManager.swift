//
//  TransactionManager.swift
//  Banking
//
//  Created by Prabesh Shrestha on 12/02/2025.
//

import Foundation
import FirebaseFirestore
class TransactionManager: TransactionProtocol {
    private let accountManager: AccountProtocol
    
    init(accountManager: AccountProtocol) {
        self.accountManager = accountManager
    }
    
    private let transactionCollection = Firestore.firestore().collection("transactions")
    
    func transactionDocumentRef(transactionId: String) -> DocumentReference{
        transactionCollection.document(transactionId)
    }
    
    func createTransaction(transaction: TransactionModel) async throws {
        let document = transactionCollection.document()
        let data:[String: Any] = [
            TransactionModel.CodingKeys.transactionId.rawValue: document.documentID,
            TransactionModel.CodingKeys.senderId.rawValue: transaction.senderAccount,
            TransactionModel.CodingKeys.receiverId.rawValue: transaction.receiverAccount,
            TransactionModel.CodingKeys.amount.rawValue: transaction.amount,
            TransactionModel.CodingKeys.transactionDate.rawValue: transaction.transactionDate,
            TransactionModel.CodingKeys.isSuccessful.rawValue: transaction.isSuccessful,
            TransactionModel.CodingKeys.error.rawValue: transaction.error ?? ""
        ]
        
        try await document.setData(data)
    }
    
    func getTransactions(userId: String) async throws -> [TransactionModel] {
        let querySnapshot = try await transactionCollection.whereField(TransactionModel.CodingKeys.senderId.rawValue, isEqualTo: userId).getDocuments()
        
        var transactions: [TransactionModel] = []
        
        for document in querySnapshot.documents {
            let transaction = try document.data(as: TransactionModel.self)
            transactions.append(transaction)
        }
        return transactions
    }
    
    func transferMoney(from senderAccountNumber: String, to recipientAccountNumber: String, amount: Double) async throws -> Bool{
        let senderDocRef = accountManager.accountDocumentReference(accountNo: senderAccountNumber)
        let recipientDocRef = accountManager.accountDocumentReference(accountNo: recipientAccountNumber)
        do {
            
            let _ = try await Firestore.firestore().runTransaction({ transaction, errorPointer -> Any? in
                do {
                    let senderSnapshot = try transaction.getDocument(senderDocRef)
                    let recipientSnapshot = try transaction.getDocument(recipientDocRef)

                    guard let senderData = try? senderSnapshot.data(as: AccountModel.self),
                          let recipientData = try? recipientSnapshot.data(as: AccountModel.self) else {
                        errorPointer?.pointee = NSError(domain: "Failed to fetch accounts", code: 500, userInfo: nil)
                        return nil
                    }

                    // Validate sufficient funds
                    if senderData.amount < amount {
                        errorPointer?.pointee = NSError(domain: "Insufficient funds", code: 400, userInfo: nil)
                        return nil
                    }

                    // Update balances
                    let newSenderBalance = senderData.amount - amount
                    let newRecipientBalance = recipientData.amount + amount

                    transaction.updateData(["amount": newSenderBalance], forDocument: senderDocRef)
                    transaction.updateData(["amount": newRecipientBalance], forDocument: recipientDocRef)
                    return nil
                } catch {
                    errorPointer?.pointee = NSError(domain: "Transaction failed", code: 500, userInfo: nil)
                    return nil
                }
            })

            // ✅ Log successful transaction outside transaction block
            let transaction = TransactionModel(
                transactionId: "",
                senderId: senderAccountNumber,
                receiverId: recipientAccountNumber,
                amount: amount,
                transactionDate: Date(),
                isSuccessful: true,
                error: ""
            )
            try await createTransaction(transaction: transaction)
            return true

        } catch {
            let failedTransaction = TransactionModel(
                transactionId: "",
                senderId: senderAccountNumber,
                receiverId: recipientAccountNumber,
                amount: amount,
                transactionDate: Date(),
                isSuccessful: false,
                error: error.localizedDescription
            )
            try await createTransaction(transaction: failedTransaction)
            return false
        }
    }



}
