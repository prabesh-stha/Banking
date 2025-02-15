//
//  RootViewModel.swift
//  Banking
//
//  Created by Prabesh Shrestha on 13/02/2025.
//

import Foundation

@MainActor
final class RootViewModel: ObservableObject{
    
    let user: AuthenticationProtocol
    
    init(user: AuthenticationProtocol){
        self.user = user
    }
    
    @Published var userId: String = ""
    @Published var errorMessage: String? = nil
    @Published var showMessage: Bool = false

    func getUser(){
            if let user = user.getUser(){
                userId = user.uid
            }else{
                errorMessage = "Couldn't get user"
                showMessage = true
            }
    }
    
}
