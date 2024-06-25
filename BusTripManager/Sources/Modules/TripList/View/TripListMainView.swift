//
//  TripListMainView.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 22/6/24.
//

import SwiftUI

struct TripListMainView: View {
    
    @StateObject var viewModel: TripListViewModel
    @State private var showingForm = false
    
    
    var body: some View {
        VStack(spacing: 10) {
            Button(action: {
               self.showingForm = true
           }) {
               Text("report_form_report_error")
           }
           .sheet(isPresented: $showingForm) {
               ErrorReportFormView()
           }
            
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
