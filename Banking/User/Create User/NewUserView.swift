//
//  NewUserView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 08/02/2025.
//

import SwiftUI

struct NewUserView: View {
    @StateObject private var viewModel: NewUserViewModel
    init() {
        _viewModel = StateObject(wrappedValue: NewUserViewModel(authManager: AuthenticationManager(), userManager: UserManager()))
    }
    @FocusState var isFirstNameFocused: Bool
    @FocusState var isLastNameFocused: Bool
    @FocusState var isMiddleNameFocused: Bool
    @FocusState var citizenshipFocused: Bool
    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @FocusState var isConfirmPasswordFocused: Bool
    @FocusState var accountNumberFocused: Bool
    @FocusState var accountTypeFocused: Bool
    @FocusState var pinFocused: Bool
    
    var body: some View {
        VStack{
            Section("User Section") {
                CustomTextField(text: $viewModel.firstName, title: "First Name", show: .constant(true), focusState: $isFirstNameFocused, imageName: "person")
                    
                CustomTextField(text: $viewModel.middleName, title: "Middle Name", show: .constant(true), focusState: $isMiddleNameFocused, imageName: "person")
                    
                CustomTextField(text: $viewModel.lastName, title: "Last Name", show: .constant(true), focusState: $isLastNameFocused, imageName: "person")
                    
                CustomTextField(text: $viewModel.email, title: "Email", show: .constant(true), focusState: $isEmailFocused, imageName: "envelope")
                    .keyboardType(.emailAddress)
                CustomTextField(text: $viewModel.password, title: "Password", show: $viewModel.showPassword, focusState: $isPasswordFocused, imageName: "lock")
                    .onChange(of: isPasswordFocused, initial: false) {
                        withAnimation(.easeInOut(duration: 0.3)){}
                    }
                    .overlay(alignment: .trailing) {
                        Button(action: {
                            viewModel.showPassword.toggle()
                                   }) {
                                       Image(systemName: viewModel.showPassword ? "eye.slash" : "eye")
                                           .foregroundColor(.gray)
                                   }
                                   .background(Color.white)
                                   .padding(.trailing, 25)
                    }
                CustomTextField(text: $viewModel.password, title: "Confirm Password", show: $viewModel.showPassword, focusState: $isConfirmPasswordFocused, imageName: "lock")
                    .onChange(of: isConfirmPasswordFocused, initial: false) {
                        withAnimation(.easeInOut(duration: 0.3)){}
                    }
                    .overlay(alignment: .trailing) {
                        Button(action: {
                            viewModel.showPassword.toggle()
                                   }) {
                                       Image(systemName: viewModel.showPassword ? "eye.slash" : "eye")
                                           .foregroundColor(.gray)
                                   }
                                   .background(Color.white)
                                   .padding(.trailing, 25)
                    }
                DatePicker("Date of birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
                    .pickerStyle(.segmented)
                    .padding()
                CustomTextField(text: $viewModel.citzenshipNo, title: "Citizenship Number", show: .constant(true), focusState: $isFirstNameFocused, imageName: "person.text.rectangle")
                    .keyboardType(.numberPad)
            }
        }
    }
}

#Preview {
    NewUserView()
}
