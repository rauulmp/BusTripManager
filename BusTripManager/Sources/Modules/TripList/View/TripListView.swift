//
//  TripListView.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 22/6/24.
//

import SwiftUI

struct TripListView: View {
    @StateObject var viewModel: TripListViewModel
    
    var body: some View {
        VStack(spacing: 10) {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                }
                
                TripMapView().frame(minHeight: 200)
                
                List(viewModel.trips) { trip in
                    TripRowView(trip: trip)
                }
                .listStyle(.plain)
                .onAppear() {
                    viewModel.fetchTrips()
                }
            }.background(Color.greyBlackBg)
    }
}

#Preview {
    TripListView(viewModel: TripListViewModel(tripService: TripService()))
}
