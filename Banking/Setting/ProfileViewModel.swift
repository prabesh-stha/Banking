//
//  ProfileViewModel.swift
//  Banking
//
//  Created by Prabesh Shrestha on 14/02/2025.
//

import Foundation
import FirebaseFirestore
@MainActor
final class ProfileViewModel: ObservableObject{
    
    let user: UserProtocol
    let auth: AuthenticationProtocol
    
    init(user: UserProtocol, auth: AuthenticationProtocol) {
        self.user = user
        self.auth = auth
    }
    
    @Published var userAccount: UserModel? = nil
    
    func getUser() async throws{
        guard let auth = auth.getUser() else { return }
        
        userAccount = try await Firestore.firestore().collection("user").document(auth.uid).getDocument(as: UserModel.self)
    }
    
}
