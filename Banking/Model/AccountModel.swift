//
//  AccountModel.swift
//  Banking
//
//  Created by Prabesh Shrestha on 08/02/2025.
//

import Foundation

struct AccountModel: Codable{
    let accountNo: String
    let country: String
    let accountType: String
    let amount: Double
    let pin: String
    let userId: String
    
    init(accountNo: String, userId: String, country: String, accountType: String, amount: Double, pin: String) {
        self.accountNo = accountNo
        self.userId = userId
        self.country = country
        self.accountType = accountType
        self.amount = amount
        self.pin = pin
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.accountNo, forKey: .accountNo)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.country, forKey: .country)
        try container.encode(self.accountType, forKey: .accountType)
        try container.encode(self.amount, forKey: .amount)
        try container.encode(self.pin, forKey: .pin)
    }
    
    enum CodingKeys: String, CodingKey {
        case accountNo = "account_no"
        case userId = "user_id"
        case country = "country"
        case accountType = "account_type"
        case amount = "amount"
        case pin = "pin"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accountNo = try container.decode(String.self, forKey: .accountNo)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.country = try container.decode(String.self, forKey: .country)
        self.accountType = try container.decode(String.self, forKey: .accountType)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.pin = try container.decode(String.self, forKey: .pin)
    }}
