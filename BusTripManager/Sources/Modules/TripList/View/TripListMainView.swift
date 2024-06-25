//
//  TripListMainView.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 22/6/24.
//

import SwiftUI

struct TripListMainView: View {
    
    @StateObject var viewModel: TripListViewModel
    @State var showingForm = false
    
    
    var body: some View {
        NavigationView {
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
            .navigationTitle("trip_list_main_view_title")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button(action: {
                    showingForm = true
                }) {
                    Image(systemName: "square.and.pencil.circle")
                        .foregroundColor(Color.mainBlack)
                }
                .sheet(isPresented: $showingForm) {
                    ErrorReportFormView()
                }
            )
            .toast(message: $viewModel.errorMessage)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    TripListMainView(viewModel: TripListViewModel(tripService: TripService()))
}
