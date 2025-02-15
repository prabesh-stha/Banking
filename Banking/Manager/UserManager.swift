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
    func getUser(userId: String) async throws -> UserModel {
        let documentSnapshot = try await userDocument(userId: userId).getDocument()
            
            // 🔹 Debug: Print raw data
//            print("📄 Raw Firestore Data: \(documentSnapshot.data() ?? [:])")
            
            return try documentSnapshot.data(as: UserModel.self)
    }
    
    
    let userCollection = Firestore.firestore().collection("user")
    
    func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }

    func createNewUser(user: UserModel) async throws {
        
        let data: [String: Any] = [
            UserModel.CodingKeys.userId.rawValue: user.userId,
            UserModel.CodingKeys.firstName.rawValue: user.firstName,
            UserModel.CodingKeys.middleName.rawValue: user.middleName ?? "",
            UserModel.CodingKeys.lastName.rawValue: user.lastName,
            UserModel.CodingKeys.dateOfBirth.rawValue: user.dateOfBirth,
            UserModel.CodingKeys.email.rawValue: user.email,
            UserModel.CodingKeys.citizenshipNo.rawValue: user.citizenshipNo,
            UserModel.CodingKeys.isVerified.rawValue: user.isVerified,
            UserModel.CodingKeys.profilePic.rawValue: user.profilePic ?? "",
        ]
        
        try await userDocument(userId: user.userId).setData(data)
    }
}
