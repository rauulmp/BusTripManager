//
//  TripMapStopCalloutView.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import SwiftUI

struct TripMapStopCalloutView: View {
   
    var stopInfo: StopInfo

    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(stopInfo.address).font(.headline)
            
            Text(stopInfo.stopTime.toDateFormat()).font(.subheadline)
            
            Text(stopInfo.userName).font(.subheadline)
            
            HStack {
                Text(stopInfo.price.description + "€")
                    .font(.subheadline)
                
                Text("(\(stopInfo.paid ? "stop_info_paid".localized() : "stop_info_not_paid".localized()))")
                    .font(.subheadline)
                    .foregroundColor(stopInfo.paid ? .green : .red)
            }
        }
        .padding()
        .background(Color.cellBgPrimary)
        .cornerRadius(8)
        .shadow(color: .cellShadowPrimary, radius: 3)
       
    }
}

#Preview {
    TripMapStopCalloutView(stopInfo: StopInfo(price: 1.5,
                                              address: "Ramblas, Barcelona",
                                              tripId: 1,
                                              paid: true,
                                              stopTime: "2018-12-18T08:10:00.000Z",
                                              point: Point(latitude: 41.37653, longitude: 2.17924),
                                              userName: "Manuel Gomez"))
}
