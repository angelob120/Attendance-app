//
//  Item.swift
//  Attendance-app
//
//  Created by AB on 9/11/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
