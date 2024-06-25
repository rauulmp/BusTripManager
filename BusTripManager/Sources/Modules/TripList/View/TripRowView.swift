//
//  TripRowView.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 22/6/24.
//

import SwiftUI

struct TripRowView: View {
    
    let trip: Trip
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(trip.description)
                .font(.headline)
                .lineLimit(1)
            
            HStack(spacing: 5) {
                VStack(alignment: .leading, spacing: 18) {
                    HStack() {
                        Image(systemName: "bus.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.mainBlack)
                            .frame(width: 20)
                        
                        Text(trip.driverName)
                            .font(.subheadline)
                            .lineLimit(1)
                    }
                    
                    HStack() {
                        Image(systemName: "circlebadge.fill")
                            .font(.system(size: 12))
                            .foregroundColor(trip.getTripStatus().color)
                            .frame(width: 20)
                        
                        Text(trip.getTripStatus().statusName)
                            .font(.subheadline)
                    }
                }
                
                Spacer()
                
                VStack() {
                    Text(trip.startTime.toDateFormat())
                        .font(.subheadline)
                    
                    Image(systemName: "point.topleft.down.curvedto.point.bottomright.up")
                        .padding(1)
                        .foregroundColor(.mainBlack)
                    
                    Text(trip.endTime.toDateFormat())
                        .font(.subheadline)
                }
                .layoutPriority(1)
            }
        }
        .padding(EdgeInsets(top: 15, leading: 20, bottom: 10, trailing: 20))
        .background(Color.cellBgPrimary)
        .cornerRadius(10)
        .shadow(color: .cellShadowPrimary, radius: 5)
        .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
    
}

#Preview {
    TripRowView(trip: Trip(driverName: "Driver Name", status: TripStatus.ongoing.rawValue, route: "", startTime: "2018-12-18T08:00:00.000Z", origin: Location(address: "addressOrigin", point: Point(latitude: 0.0, longitude: 0.0)), description: "Barcelona a Martorell", destination: Location(address: "addressDestination", point: Point(latitude: 0.0, longitude: 0.0)), stops: [], endTime: "2018-12-18T09:00:00.000Z"))
}
