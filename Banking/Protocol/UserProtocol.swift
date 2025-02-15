//
//  UserProtocol.swift
//  Banking
//
//  Created by Prabesh Shrestha on 08/02/2025.
//

import Foundation
import Combine

protocol UserProtocol {
    func createNewUser(user: UserModel) async throws
    func getUser(userId: String) -> AnyPublisher<UserModel, Error>
    func createAccount(userId: String, account: AccountModel) async throws
    func getAccount(userId: String) -> AnyPublisher< AccountModel, Error>
}
