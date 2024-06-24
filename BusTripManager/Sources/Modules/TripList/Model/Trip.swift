//
//  Trip.swift
//  BusTripManager
//
//  Created by Raul Montoya Perez on 20/6/24.
//

import Foundation

struct Trip: Codable, Identifiable {
    let id = UUID()
    let driverName: String
    let status: String
    let route: String
    let startTime: String
    let origin: Location
    let description: String
    let destination: Location
    let stops: [Stop]
    let endTime: String
    
    func getTripStatus() -> TripStatus {
        return TripStatus(from: status)
    }
}
