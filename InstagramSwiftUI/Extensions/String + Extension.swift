//
//  String + Extension.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let trimmedEmail = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: trimmedEmail)
    }
    
    var isPasswordValid: Bool {
        let trimmedPassword = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmedPassword.isEmpty && trimmedPassword.count >= 6 
    }

    /**
     Validates a password based on the given criteria.

     - Parameters:
        - password: The password string to be validated.
        - minLength: The minimum length for the password. Default is 8.
        - hasUppercase: Whether the password must contain at least one uppercase letter. Default is true.
        - hasLowercase: Whether the password must contain at least one lowercase letter. Default is true.
        - hasNumber: Whether the password must contain at least one number. Default is true.
        - hasSymbol: Whether the password must contain at least one special character (e.g., !@#$%^&*()). Default is true.

     - Returns: A Boolean value indicating whether the password meets all the specified criteria.
     */
    func isValidPassword(minLength: Int = 8, hasUppercase: Bool = true, hasLowercase: Bool = true, hasNumber: Bool = true, hasSymbol: Bool = true) -> Bool {
        // Trim whitespace and newlines
        let trimmedPassword = self.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check password length
        if trimmedPassword.count < minLength {
            return false
        }

        // Regular expressions for different character classes
        let uppercaseRegex = ".*[A-Z]+.*"
        let lowercaseRegex = ".*[a-z]+.*"
        let numberRegex = ".*\\d+.*"
        let symbolRegex = ".*[!@#$%^&*()]+.*"

        // Check for character classes based on requirements
        if hasUppercase && !NSPredicate(format: "SELF MATCHES %@", uppercaseRegex).evaluate(with: trimmedPassword) {
            return false
        }
        if hasLowercase && !NSPredicate(format: "SELF MATCHES %@", lowercaseRegex).evaluate(with: trimmedPassword) {
            return false
        }
        if hasNumber && !NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: trimmedPassword) {
            return false
        }
        if hasSymbol && !NSPredicate(format: "SELF MATCHES %@", symbolRegex).evaluate(with: trimmedPassword) {
            return false
        }

        // Password meets all requirements
        return true
    }
}
