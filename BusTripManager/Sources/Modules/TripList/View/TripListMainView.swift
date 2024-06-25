//
//  TripListMainView.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 22/6/24.
//

import SwiftUI

struct TripListMainView: View {
    @StateObject var viewModel: TripListViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            TripMapView(polylineCoordinates: $viewModel.selectedTripPolylineCoordinates,
                        mapAnnotations: $viewModel.selectedTripMapAnnotations)
            .frame(height: 300)
            
            TripListView(trips: viewModel.trips, onSelectTrip: viewModel.selectTrip)
            .onAppear {
                viewModel.fetchTrips()
                viewModel.fetchStops()
            }
        }
        .background(Color.greyBlackBg)
        .toast(message: $viewModel.errorMessage)
    }
}

#Preview {
    TripListMainView(viewModel: TripListViewModel(tripService: TripService()))
}
