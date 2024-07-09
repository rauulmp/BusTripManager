//
//  ContentView.swift
//  BusTripManager
//
//  Created by Raul Montoya Perez on 19/6/24.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        TripListMainView(viewModel:
                            TripListViewModel(businessLogic: TripBusinessLogic(tripService: TripService())))
    }

}

#Preview {
    ContentView()
}
