//
//  ErrorReportFormView.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import SwiftUI

struct ErrorReportFormView: View {
    
    @StateObject private var viewModel = ErrorReportFormViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("report_form_personal_info_header")) {
                    TextField("report_form_name_hint", text: $viewModel.firstName)
                    TextField("report_form_surname_hint", text: $viewModel.lastName)
                    TextField("report_form_phone_hint", text: $viewModel.phone)
                    TextField("report_form_email_hint", text: $viewModel.email)
                }
                
                Section(header: Text("report_form_details_header")) {
                    DatePicker("report_form_date_hint", selection: $viewModel.date)
                    TextField("report_form_comment_hint", text: $viewModel.comment)
                }
                
                Button(action: {
                    if viewModel.validateForm() {
                        viewModel.saveReport()
                    } else {
                        viewModel.showingAlert = true
                    }
                }) {
                    Text("report_form_send_btn")
                }
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("common_error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("common_ok")))
                }
            }
            .navigationBarTitle("report_form_report_error")
        }
    }
    
}
