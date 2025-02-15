//
//  ChangePinView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 12/02/2025.
//

import SwiftUI

struct ChangePinView: View {
    @StateObject private var viewModel: ChangePinViewModel
    @FocusState private var focusedIndex: Int?
    let accountNo: String
    @Environment(\.dismiss) var dismiss

    init(accountNo: String) {
        _viewModel = StateObject(wrappedValue: ChangePinViewModel(account: AccountManager()))
        self.accountNo = accountNo
    }
    var body: some View {
        VStack(spacing: 20) {
                    Text("Change PIN")
                        .font(.title)
                        .bold()

            PinEntryField(title: "Current PIN", pinArray: $viewModel.currentPIN, focusedIndex: _focusedIndex, baseIndex: 0, isComplete: viewModel.isCurrentPinComplete)


                    PinEntryField(title: "New PIN", pinArray: $viewModel.newPIN, focusedIndex: _focusedIndex, baseIndex: 4, isComplete: viewModel.isNewPinComplete)


                    PinEntryField(title: "Confirm New PIN", pinArray: $viewModel.confirmPIN, focusedIndex: _focusedIndex, baseIndex: 8, isComplete: viewModel.isConfirmPinComplete)

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }

                    Button("Change PIN") {
                        Task{
                            try await viewModel.changePin(accountNo: accountNo)
                            
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 10)
                }
                .padding()
                .alert("Message", isPresented: $viewModel.showMessage) {
                    Button("OK"){
                        dismiss()
                    }
                } message: {
                    Text(viewModel.message)
                }
    }
}

#Preview {
    ChangePinView(accountNo: "")
}
