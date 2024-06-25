//
//  DataValidationUtils.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import Foundation

class DataValidationUtils {
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    static func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        // Basic method to validate phone number (8 digits), it can be improved with some library
        let phoneRegex = "^\\d{8,}$"
        let phonePredicate = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phoneNumber)
    }
    
}
