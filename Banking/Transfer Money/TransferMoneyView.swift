//
//  TransferMoneyView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 12/02/2025.
//

import SwiftUI

struct TransferMoneyView: View {
    @StateObject private var viewModel: TransferMoneyViewModel
    @FocusState var isAccountFocused: Bool
    @FocusState var isUserFocused: Bool
    @FocusState var isNumberFocused: Bool
    @FocusState var isAmountFocused: Bool
    let userId: String
    @Environment(\.dismiss) var dismiss
    
    
    init(userId: String) {
        _viewModel = StateObject(wrappedValue: TransferMoneyViewModel(account: AccountManager(), transaction: TransactionManager(accountManager: AccountManager()), user: UserManager()))
        self.userId = userId
    }
    var body: some View {
        VStack{
            if let errorMessage = viewModel.errorMessage{
                Text(errorMessage)
                    .font(.caption2)
                    .foregroundStyle(Color.red)
            }
            CustomTextField(text: $viewModel.accountNumber, title: "Account Number", show: .constant(true), focusState: $isAccountFocused, imageName: "number.circle")
                .keyboardType(.numberPad)
                .padding(.bottom)
                .onChange(of: viewModel.accountNumber) { oldValue, newValue in
                    // Restrict input to the first 16 digits
                    if oldValue.count > 16 {
                        viewModel.accountNumber = String(oldValue.prefix(16))
                    }
                }
            CustomTextField(text: $viewModel.receiverName, title: "Receiver Name", show: .constant(true), focusState: $isUserFocused, imageName: "person.circle")
                .padding(.bottom)
                .disabled(true)
            CustomTextField(text: $viewModel.receiverNumber, title: "Phone Number", show: .constant(true), focusState: $isNumberFocused, imageName: "phone.circle")
                .keyboardType(.numberPad)
                .padding(.bottom)
                .disabled(true)
            CustomTextField(text: $viewModel.amount, title: "Amount", show: .constant(true), focusState: $isAmountFocused, imageName: "banknote")
                .keyboardType(.numberPad)
                .padding(.bottom)
            Button{
                Task{
                    viewModel.showPinSheet = true
                }
            } label: {
                Text("Send Money")
            }
        }
        .sheet(isPresented: $viewModel.showPinSheet) {
            VStack{
                PinEntryField(title: "Enter pin", pinArray: $viewModel.pin, baseIndex: 0, isComplete: viewModel.isPinComplete)
                Button("Send"){
                    Task{
                        try await viewModel.transerMoney(userId: userId)
                    }
                }
            }
        }
        .alert("Message", isPresented: $viewModel.showAlert) {
            Button("OK"){
                dismiss()
            }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}


#Preview {
    TransferMoneyView(userId: "")
}
