//
//  AccountProtocol.swift
//  Banking
//
//  Created by Prabesh Shrestha on 11/02/2025.
//

import Foundation
import Combine
import FirebaseFirestore

protocol AccountProtocol{
//    func createAccount(accountId: Int, account: AccountModel) async throws
    func getAccountWithCombine(accountNo: String) -> AnyPublisher< AccountModel, Error>
    func getAccount(accountNo: String) async throws -> AccountModel
    
    func changePin(accountNo: String, currentPin: String, newPin: String) async throws
    
    func validatePin(accountNo: String, pin: String) async throws -> Bool
    
    func getAccountWithUserId(userId: String) async throws -> AccountModel?
    
    func accountDocumentReference(accountNo: String) -> DocumentReference
    }
