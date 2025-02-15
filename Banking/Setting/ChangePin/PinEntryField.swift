//
//  PinEntryField.swift
//  Banking
//
//  Created by Prabesh Shrestha on 12/02/2025.
//

import SwiftUI
struct PinEntryField: View {
    let title: String
    @Binding var pinArray: [String]
    @FocusState var focusedIndex: Int?
    let baseIndex: Int
    let isComplete: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)

            HStack(spacing: 10) {
                ForEach(0..<4, id: \.self) { index in
                    pinBox(index: index)
                }
            }
        }
        .onAppear { focusedIndex = baseIndex }
    }


    private func pinBox(index: Int) -> some View {
        TextField("", text: $pinArray[index], onEditingChanged: { _ in }, onCommit: {})
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .frame(width: 50, height: 50)
            .background(isComplete ? Color.gray.opacity(0.2) : Color.red.opacity(0.3))
            .cornerRadius(10)
            .focused($focusedIndex, equals: baseIndex + index)
            .onChange(of: pinArray[index]) { oldValue, newValue in
                handleInput(oldValue, index: index)
            }
    }

    private func handleInput(_ newValue: String, index: Int) {
        if newValue.count > 1 {
            pinArray[index] = String(newValue.last!)
        }
        if newValue.isEmpty, index > 0 {
            focusedIndex = baseIndex + index - 1
        } else if newValue.count == 1, index < 3 {
            focusedIndex = baseIndex + index + 1 
        }
    }
}


#Preview {
    PinEntryField(title: "", pinArray: .constant([]), baseIndex: 0, isComplete: false)
}
