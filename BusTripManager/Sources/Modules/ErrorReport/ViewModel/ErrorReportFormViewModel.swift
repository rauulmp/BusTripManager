//
//  ErrorReportFormViewModel.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import SwiftUI

class ErrorReportFormViewModel: ObservableObject {
    
    private let businessLogic: ErrorReportBusinessLogicProtocol
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var date = Date()
    @Published var comment = ""
    
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    
    init(businessLogic: ErrorReportBusinessLogicProtocol = ErrorReportBusinessLogic()) {
        self.businessLogic = businessLogic
    }
    
    func validateForm() -> Bool {
        if let errorMessage = businessLogic.validateForm(firstName: firstName, 
                                                         lastName: lastName,
                                                         phone: phone,
                                                         email: email,
                                                         comment: comment) {
             alertMessage = errorMessage
             showingAlert = true
             return false
         }
         return true
    }
    
    func saveReport() {
        businessLogic.saveReport(firstName: firstName,
                                 lastName: lastName,
                                 phone: phone,
                                 email: email,
                                 date: date,
                                 comment: comment)
    }
   
}
