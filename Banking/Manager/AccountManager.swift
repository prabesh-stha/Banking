//
//  AccountManager.swift
//  Banking
//
//  Created by Prabesh Shrestha on 11/02/2025.
//

import Foundation
import Combine
import FirebaseFirestore

class AccountManager: AccountProtocol{
    func getAccountWithUserId(userId: String) async throws -> AccountModel? {
        let querySnapshot = try await accountCollection.whereField(AccountModel.CodingKeys.userId.rawValue, isEqualTo: userId).getDocuments()
        let account = try querySnapshot.documents.first.map { snapshot in
           try snapshot.data(as: AccountModel.self)
        }
        return account
    }
    
    func validatePin(accountNo: String, pin: String) async throws -> Bool{
        let account = try await getAccount(accountNo: accountNo)
        let decryptpin = EncryptDecrypt(keyString: accountNo).decrypt(encryptedText: account.pin)
        if let decryptpin{
            if pin == decryptpin{
                return true
            }
        }
        return false
    }
    
    
    func changePin(accountNo: String, currentPin: String, newPin: String) async throws {
        let validated = try await validatePin(accountNo: accountNo, pin: currentPin)
        let encryptedPin = EncryptDecrypt(keyString: accountNo).encrypt(text: newPin)
        if let encryptedPin{
            let data: [String: Any] = [
                AccountModel.CodingKeys.pin.rawValue: encryptedPin
            ]
            if validated{
                try await accountDocumentReference(accountNo: accountNo).updateData(data)
            }
        }
        
    }
    
    
    private let accountCollection = Firestore.firestore().collection("accounts")
    func accountDocumentReference(accountNo: String) -> DocumentReference {
        accountCollection.document("\(accountNo)")
    }
    func getAccountWithCombine(accountNo: String) -> AnyPublisher<AccountModel, any Error> {
        let publisher = PassthroughSubject<AccountModel, Error>()
        accountDocumentReference(accountNo: accountNo).addSnapshotListener { snapshot, error in
            guard let snapshot else { return }
            
            if let document = try? snapshot.data(as: AccountModel.self) {
                publisher.send(document)
            }
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func getAccount(accountNo: String) async throws -> AccountModel {
        try await accountDocumentReference(accountNo: accountNo).getDocument().data(as: AccountModel.self)
    }
    
    
    
    
    
    
}
