//
//  UserModel.swift
//  Banking
//
//  Created by Prabesh Shrestha on 08/02/2025.
//

import Foundation

struct UserModel: Codable{
    let userId: String
    let firstName: String
    let middleName:String?
    let lastName: String
    let dateOfBirth: Date
    let email: String
    let citizenshipNo: String
    let isVerified: Bool
    let profilePic: String?
    let phoneNo: String
    
    
    init(userId: String, firstName: String, middleName: String?, lastName: String, dateOfBirth: Date, email: String, citizenshipNo: String, isVerified: Bool, profilePic: String?, phoneNo: String) {
        self.userId = userId
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.email = email
        self.citizenshipNo = citizenshipNo
        self.isVerified = isVerified
        self.profilePic = profilePic
        self.phoneNo = phoneNo
        
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encodeIfPresent(self.middleName, forKey: .middleName)
        try container.encode(self.lastName, forKey: .lastName)
        try container.encode(self.dateOfBirth, forKey: .dateOfBirth)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.citizenshipNo, forKey: .citizenshipNo)
        try container.encode(self.isVerified, forKey: .isVerified)
        try container.encodeIfPresent(self.profilePic, forKey: .profilePic)
        try container.encode(self.phoneNo, forKey: .phoneNo)
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case dateOfBirth = "date_of_birth"
        case email = "email"
        case citizenshipNo = "citizenship_no"
        case isVerified = "is_verified"
        case profilePic = "profile_pic"
        case phoneNo = "phone_no"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.middleName = try container.decodeIfPresent(String.self, forKey: .middleName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.dateOfBirth = try container.decode(Date.self, forKey: .dateOfBirth)
        self.email = try container.decode(String.self, forKey: .email)
        self.citizenshipNo = try container.decode(String.self, forKey: .citizenshipNo)
        self.isVerified = try container.decode(Bool.self, forKey: .isVerified)
        self.profilePic = try container.decodeIfPresent(String.self, forKey: .profilePic)
        self.phoneNo = try container.decode(String.self, forKey: .phoneNo)
    }

}
