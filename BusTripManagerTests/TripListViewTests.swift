//
//  TripListViewTests.swift
//  BusTripManagerTests
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import XCTest
import RxTest
import RxSwift
import SwiftUI
@testable import BusTripManager

class TripListViewTests: XCTestCase {

    func testOnSelectTrip() {
        var selectedTrip: Trip?
        let trips = [
            Trip(driverName: "Driver1",
                 status: "ongoing",
                 route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@",
                 startTime: "2018-12-19T08:00:00.000Z",
                 origin: Location(address: "originLocation1", point: Point(latitude: 41.38074, longitude: 2.18594)),
                 description: "trip1 description",
                 destination: Location(address: "destinationLocation1", point: Point(latitude: 41.49958, longitude: 1.90307)),
                 stops: [Stop(point: Point(latitude: 41.35179, longitude: 2.15494), id: 1)],
                 endTime: "2018-12-19T10:00:00.000Z"),
            Trip(driverName: "Driver2",
                 status: "scheduled",
                 route: "",
                 startTime: "2018-12-18T08:00:00.000Z",
                 origin: Location(address: "originLocation2", point: Point(latitude: 0.0, longitude: 0.0)),
                 description: "trip2 description",
                 destination: Location(address: "destinationLocation2", point: Point(latitude: 0.0, longitude: 0.0)),
                 stops: [],
                 endTime: "2018-12-18T09:00:00.000Z")
        ]
        
        let listView = TripListView(trips: trips) { trip in
            selectedTrip = trip
        }
        
        listView.onSelectTrip(trips[0])
        
        XCTAssertEqual(selectedTrip?.driverName, trips[0].driverName)
    }
        
}

