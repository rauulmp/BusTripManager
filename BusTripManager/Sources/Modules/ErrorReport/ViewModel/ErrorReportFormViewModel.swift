//
//  ErrorReportFormViewModel.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import SwiftUI

class ErrorReportFormViewModel: ObservableObject {
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var date = Date()
    @Published var comment = ""
    
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    
    func validateForm() -> Bool {
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || comment.isEmpty {
            alertMessage = "report_form_required_field_error".localized()
            return false
        }
        
        if !DataValidationUtils.isValidEmail(email) {
            alertMessage = "report_form_invalid_email_error".localized()
            return false
        }
        
        if !phone.isEmpty && !DataValidationUtils.isValidPhoneNumber(phone) {
            alertMessage = "report_form_invalid_phone_error".localized()
            return false
        }
        return true
    }
    
    func saveReport() {
        ReportDataManager.shared.saveReport(firstName: firstName,
                                            lastName: lastName,
                                            phone: phone,
                                            email: email,
                                            date: date,
                                            comment: comment)
        
        ApplicationUtils.updateBadgeNumber(count: ReportDataManager.shared.getReportsCount())
    }
   
}
