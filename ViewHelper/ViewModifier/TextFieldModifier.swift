//
//  textFieldModifier.swift
//  Banking
//
//  Created by Prabesh Shrestha on 06/02/2025.
//

import Foundation
import SwiftUI

struct TextFieldModifier: ViewModifier{
    var isFocused: FocusState<Bool>.Binding
    let imageName: String
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading,55)
            .frame(height: 55)
            .overlay {
                ZStack(alignment: .leading){
                    Image(systemName: imageName)
                        .padding()
                        .font(.title2)
                    RoundedRectangle(cornerRadius: 10).stroke(isFocused.wrappedValue ? Color.blue : Color.gray, style: StrokeStyle(lineWidth: 1))
                        .animation(.easeInOut(duration: 0.3), value: isFocused.wrappedValue)
                }
            }
            .padding(.horizontal)
        
    }
}

extension View{
    public func textFieldStyle(isFocused: FocusState<Bool>.Binding, imageName: String) -> some View{
        self.modifier(TextFieldModifier(isFocused: isFocused, imageName: imageName))
    }
}
