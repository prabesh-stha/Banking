//
//  LogInView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 06/02/2025.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var authViewModel: AuthenticationViewModel
    @State private var showPassword: Bool = false
    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool
    var body: some View {
        VStack{
            CustomTextField(text: $authViewModel.email, title: "Email", show: .constant(true), focusState: $isEmailFocused, imageName: "envelope")
                .onChange(of: isEmailFocused, initial: false) {
                    withAnimation(.easeInOut(duration: 0.3)){}
                }
            CustomTextField(text: $authViewModel.password, title: "Password", show: $showPassword, focusState: $isPasswordFocused, imageName: "lock")
                .onChange(of: isEmailFocused, initial: false) {
                    withAnimation(.easeInOut(duration: 0.3)){}
                }
                .overlay(alignment: .trailing) {
                    Button(action: {
                        showPassword.toggle()
                               }) {
                                   Image(systemName: showPassword ? "eye.slash" : "eye")
                                       .foregroundColor(.gray)
                                       .padding(.trailing, 20)
                               }
                }
                
                

        }
    }
}

#Preview {
    SignInView(authViewModel: AuthenticationViewModel(auth: AuthenticationManager()))
}
