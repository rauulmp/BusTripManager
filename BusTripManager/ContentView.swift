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
        TripListView(viewModel:
                        TripListViewModel(tripService: TripService()))
    }

}

#Preview {
    ContentView()
}
