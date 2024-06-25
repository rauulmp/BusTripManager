//
//  ReportDataManager.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import Foundation

class ReportDataManager {
    
    static let shared = ReportDataManager()
    
    private init() {}
    
    func saveReport(firstName: String, lastName: String, phone: String, 
                    email: String, date: Date, comment: String) {
        
        let reportDict: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "phone": phone,
            "email": email,
            "date": date,
            "comment": comment
        ]
        
        var reports = loadReports()
        reports.append(reportDict)
        
        (reports as NSArray).write(to: getPlistPath(), atomically: true)
    }
    
    func loadReports() -> [[String: Any]] {
        if let reports = NSArray(contentsOf: getPlistPath()) as? [[String: Any]] {
            return reports
        }
        return []
    }
    
    func getReportsCount() -> Int {
        return loadReports().count
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func getPlistPath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(Constants.Plist.reports)
    }
}
