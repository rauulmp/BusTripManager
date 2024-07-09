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
            return "trip_status_scheduled".localized()
        case .ongoing:
            return "trip_status_ongoing".localized()
        case .finalized:
            return "trip_status_finalized".localized()
        case .cancelled:
            return "trip_status_cancelled".localized()
        case .undefined:
            return "trip_status_undefined".localized()
        }
    }
    
    init(from string: String) {
        self = TripStatus(rawValue: string) ?? .undefined
    }
    
    func isAvailable() -> Bool {
        switch self {
        case .scheduled, .ongoing:
            return true
        case .finalized, .cancelled, .undefined:
            return false
        }
    }
}

enum TripMapAnnotationType: String {
    case limit
    case stop
    
    var imageName: String {
        switch self {
        case .limit:
            return "dot.circle"
        case .stop:
            return "largecircle.fill.circle"
        }
    }
}
