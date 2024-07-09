//
//  ErrorReportBusinessLogic.swift
//  BusTripManager
//
//  Created by Raul Montoya Perez on 9/7/24.
//

import Foundation

protocol ErrorReportBusinessLogicProtocol {
    func validateForm(firstName: String, lastName: String, phone: String, email: String, comment: String) -> String?
    func saveReport(firstName: String, lastName: String, phone: String, email: String, date: Date, comment: String)
}

class ErrorReportBusinessLogic: ErrorReportBusinessLogicProtocol {
    
    func validateForm(firstName: String, lastName: String, phone: String, email: String, comment: String) -> String? {
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || comment.isEmpty {
            return "report_form_required_field_error".localized()
        }

        if !DataValidationUtils.isValidEmail(email) {
            return "report_form_invalid_email_error".localized()
        }

        if !phone.isEmpty && !DataValidationUtils.isValidPhoneNumber(phone) {
            return "report_form_invalid_phone_error".localized()
        }

        return nil
    }

    func saveReport(firstName: String, lastName: String, phone: String, email: String, date: Date, comment: String) {
        ReportDataManager.shared.saveReport(firstName: firstName,
                                            lastName: lastName,
                                            phone: phone,
                                            email: email,
                                            date: date,
                                            comment: comment)

        ApplicationUtils.updateBadgeNumber(count: ReportDataManager.shared.getReportsCount())
    }
}
