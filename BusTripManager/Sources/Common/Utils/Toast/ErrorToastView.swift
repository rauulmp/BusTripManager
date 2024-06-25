//
//  ErrorToastView.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import SwiftUI

struct ErrorToastView: View {
    var message: String

    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle")
                .foregroundColor(.white)
                .padding()
            Text(message)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
        }
        .background(Color.red)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(.top, 50)
    }
}
