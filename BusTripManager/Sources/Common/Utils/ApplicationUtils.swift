//
//  ApplicationUtils.swift
//  BusTripManager
//
//  Created by Raúl Montoya Pérez on 25/6/24.
//

import SwiftUI

class ApplicationUtils {
    
    static func updateBadgeNumber(count: Int) {
        if #available(iOS 16.0, *) {
            UNUserNotificationCenter.current().setBadgeCount(count) { error in
                if let error = error {
                    print("Error setting BadgeCount: ", error.localizedDescription)
                    return
                }
            }
        } else {
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
    
}
