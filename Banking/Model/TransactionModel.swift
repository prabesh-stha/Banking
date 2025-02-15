//
//  TransactionModel.swift
//  Banking
//
//  Created by Prabesh Shrestha on 08/02/2025.
//

import Foundation

struct TransactionModel: Codable{
    let transactionId: String
    let senderAccount: String
    let receiverAccount: String
    let amount: Double
    let transactionDate: Date
    let isSuccessful: Bool
    let error: String?
    
    init(transactionId: String, senderId: String, receiverId: String, amount: Double, transactionDate: Date, isSuccessful: Bool, error: String) {
        self.transactionId = transactionId
        self.senderAccount = senderId
        self.receiverAccount = receiverId
        self.amount = amount
        self.transactionDate = transactionDate
        self.isSuccessful = isSuccessful
        self.error = error
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.transactionId = try container.decode(String.self, forKey: .transactionId)
        self.senderAccount = try container.decode(String.self, forKey: .senderId)
        self.receiverAccount = try container.decode(String.self, forKey: .receiverId)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.transactionDate = try container.decode(Date.self, forKey: .transactionDate)
        self.isSuccessful = try container.decode(Bool.self, forKey: .isSuccessful)
        self.error = try container.decodeIfPresent(String.self, forKey: .error)
    }
    
    enum CodingKeys: String, CodingKey {
        case transactionId = "transaction_id"
        case senderId = "sender_id"
        case receiverId = "receiver_id"
        case amount = "amount"
        case transactionDate = "transaction_date"
        case isSuccessful = "is_successful"
        case error = "error"
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.transactionId, forKey: .transactionId)
        try container.encode(self.senderAccount, forKey: .senderId)
        try container.encode(self.receiverAccount, forKey: .receiverId)
        try container.encode(self.amount, forKey: .amount)
        try container.encode(self.transactionDate, forKey: .transactionDate)
        try container.encode(self.isSuccessful, forKey: .isSuccessful)
        try container.encode(self.error, forKey: .error)
    }
    
}
