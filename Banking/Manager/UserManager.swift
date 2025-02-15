//
//  UserManager.swift
//  Banking
//
//  Created by Prabesh Shrestha on 08/02/2025.
//

import Foundation
import FirebaseFirestore
import Combine

class UserManager: UserProtocol{
    
    func getAccount(acountNo: Int) async throws{
        let account = try await userCollection.document(String(acountNo)).getDocument().data(as: AccountModel.self)
    }
    func getUser(userId: String) -> AnyPublisher<UserModel, any Error> {
        let publisher = PassthroughSubject<UserModel, Error>()
        userDocument(userId: userId).addSnapshotListener { querySnapShot, error in
            guard let querySnapShot else {
                return
            }
            
            if let user = try? querySnapShot.data(as: UserModel.self){
                return publisher.send(user)
            }
        }
        return publisher.eraseToAnyPublisher()
    }
    
    private let userCollection = Firestore.firestore().collection("users")
    private func accountCollection(userId: String) -> CollectionReference {
        userCollection.document(userId).collection("account")
    }
    
    func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func accountDocument(userId: String, accountNo: Int) -> DocumentReference {
        accountCollection(userId: userId).document(String(accountNo))
    }
    
    internal func createAccount(userId: String, account: AccountModel) async throws {
        if let encryptedPin = EncryptDecrypt(keyString: "\(userId)\(account.accountNo)").encrypt(text: String(account.pin)){
            let data: [String: Any] = [
                AccountModel.CodingKeys.accountNo.rawValue: account.accountNo,
                AccountModel.CodingKeys.country.rawValue: account.country,
                AccountModel.CodingKeys.accountType.rawValue: account.accountType,
                AccountModel.CodingKeys.amount.rawValue: account.amount,
                AccountModel.CodingKeys.pin.rawValue: Int(encryptedPin)!
            ]
            try await accountCollection(userId: userId).document().setData(data)
        }else{
            return
        }
    }
    
    func getAccount(userId: String) -> AnyPublisher<AccountModel, any Error> {
        let publisher = PassthroughSubject<AccountModel, Error>()
        accountCollection(userId: userId).addSnapshotListener { querySnapShot, error in
            guard let querySnapShot else {
                return
            }
            
            
            if let account = try? querySnapShot.documents.first?.data(as: AccountModel.self){
                publisher.send(account)
            }
        }
        return publisher.eraseToAnyPublisher()
    }

    
    func createNewUser(user: UserModel) async throws {
        let document = userCollection.document()
        
        let data: [String: Any] = [
            UserModel.CodingKeys.userId.rawValue: document.documentID,
            UserModel.CodingKeys.firstName.rawValue: user.firstName,
            UserModel.CodingKeys.middleName.rawValue: user.middleName ?? "",
            UserModel.CodingKeys.lastName.rawValue: user.lastName,
            UserModel.CodingKeys.dateOfBirth.rawValue: user.dateOfBirth,
            UserModel.CodingKeys.email.rawValue: user.email,
            UserModel.CodingKeys.citizenshipNo.rawValue: user.citizenshipNo,
            UserModel.CodingKeys.isVerified.rawValue: user.isVerified,
            UserModel.CodingKeys.profilePic.rawValue: user.profilePic ?? "",
        ]
        
        try await userDocument(userId: document.documentID).setData(data)
    }
}
