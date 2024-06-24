//
//  StringExtension.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 23/6/24.
//

import Foundation

extension String {
    func toDateFormat() -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let date = dateFormatter.date(from: self) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
        return self
    }
}
