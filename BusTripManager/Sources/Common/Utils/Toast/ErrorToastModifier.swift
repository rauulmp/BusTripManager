//
//  ErrorToastModifier.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import SwiftUI

struct ErrorToastModifier: ViewModifier {
    @Binding var message: String?

    func body(content: Content) -> some View {
        ZStack {
            content
            if let message = message, !message.isEmpty {
                VStack {
                    ErrorToastView(message: message)
                    Spacer()
                }
                .transition(.slide)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            self.message = nil
                        }
                    }
                }
            }
        }
    }
}
