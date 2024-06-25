//
//  TripListView.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import SwiftUI

struct TripListView: View {
    var trips: [Trip]
    var onSelectTrip: (Trip) -> Void = { _ in }
    
    var body: some View {
        List(trips) { trip in
            TripRowView(trip: trip)
                .onTapGesture {
                    onSelectTrip(trip)
                }
        }
        .listStyle(.plain)
    }
}

#Preview {
    TripListView(trips: TripListViewModel(tripService: TripService()).trips)
}
