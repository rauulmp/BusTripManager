//
//  Point.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 22/6/24.
//

import Foundation

struct Point: Codable {
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "_latitude"
        case longitude = "_longitude"
    }
}
