//
//  StopInfo.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import Foundation

struct StopInfo: Codable {
    let price: Double
    let address: String
    let tripId: Int
    let paid: Bool
    let stopTime: String
    let point: Point
    let userName: String
}
