//
//  Enums.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 23/6/24.
//

import SwiftUI

enum TripStatus: String {
    case scheduled
    case ongoing
    case finalized
    case cancelled
    case undefined
    
    var color: Color {
        switch self {
        case .scheduled:
            return .blue
        case .ongoing:
            return .green
        case .finalized:
            return .gray
        case .cancelled:
            return .red
        case .undefined:
            return .black
        }
    }
    
    var statusName: String {
        switch self {
        case .scheduled:
            return "Scheduled"
        case .ongoing:
            return "Ongoing"
        case .finalized:
            return "Finalized"
        case .cancelled:
            return "Cancelled"
        case .undefined:
            return "Undefined"
        }
    }
    
    init(from string: String) {
        self = TripStatus(rawValue: string) ?? .undefined
    }
}
