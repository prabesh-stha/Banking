//
//  CustomTextField.swift
//  Banking
//
//  Created by Prabesh Shrestha on 06/02/2025.
//

import Foundation
import SwiftUI

struct CustomTextField: View{
    @Binding var text: String
    let title: String
    @Binding var show: Bool
    var focusState: FocusState<Bool>.Binding
    let imageName: String
    var body: some View{
            ZStack{
                if show{
                    TextField(title, text: $text)
                        .focused(focusState)
                }else{
                    SecureField(title, text: $text)
                        .focused(focusState)
                }
            }
            
            .textFieldStyle(isFocused: focusState, imageName: imageName)
            
    }
}
//
//#Preview {
//    CustomTextField(text: .constant(""), title: "Email", show: .constant(true), focusState: FocusState.Binding(false), imageName: "")
//}
