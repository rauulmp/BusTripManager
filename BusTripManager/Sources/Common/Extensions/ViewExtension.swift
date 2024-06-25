//
//  ViewExtension.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import SwiftUI

extension View {
    func toast(message: Binding<String?>) -> some View {
        self.modifier(ErrorToastModifier(message: message))
    }
}
