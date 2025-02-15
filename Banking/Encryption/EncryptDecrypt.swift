//
//  EncryptDecrypt.swift
//  Banking
//
//  Created by Prabesh Shrestha on 08/02/2025.
//

import CryptoKit
import Foundation

struct EncryptDecrypt {
    private let key: SymmetricKey
    
    init(keyString: String) {
        let keyData = SHA256.hash(data: keyString.data(using: .utf8)!)
        key = SymmetricKey(data: keyData)
    }
    
    // Encrypt a text string and return the base64-encoded result
    func encrypt(text: String) -> String? {
        guard let data = text.data(using: .utf8) else { return nil }
        guard let sealedBox = try? ChaChaPoly.seal(data, using: key) else { return nil }
        return sealedBox.combined.base64EncodedString()
    }
    
    // Decrypt a base64-encoded string and return the original text
    func decrypt(encryptedText: String) -> String? {
        guard let data = Data(base64Encoded: encryptedText),
              let sealedBox = try? ChaChaPoly.SealedBox(combined: data),
              let decryptedData = try? ChaChaPoly.open(sealedBox, using: key) else {
            return nil
        }
        return String(data: decryptedData, encoding: .utf8)
    }
}
