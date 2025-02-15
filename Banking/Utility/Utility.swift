//
//  Utility.swift
//  Banking
//
//  Created by Prabesh Shrestha on 15/02/2025.
//

import Foundation

class Utility{
    static func formattedAmount(amount: Double) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    static func capitalizeFirstLetter(of string: String?) -> String? {
        if let string = string {
            guard let firstCharacter = string.first else {
                return string
            }
            let remainingString = string.dropFirst()
            return String(firstCharacter).uppercased() + remainingString
        }
        return nil
    }
}
