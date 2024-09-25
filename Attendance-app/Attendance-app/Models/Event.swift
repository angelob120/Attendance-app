//
//  Event.swift
//  Attendance-app
//
//  Created by Keon Johnson on 9/16/24.
//


import CoreLocation

struct Events: Identifiable {
    let id: String
    var title: String
    var venue: String
    var description: String
    var date: Date
  
    init(id: String = UUID().uuidString, title: String, venue: String, description: String, date: Date) {
        self.id = id
        self.title = title
        self.venue = venue
        self.description = description
        self.date = date
    }
    
    static var sampleEvents = [
        Events(title: "My Concert", venue: "The Club", description: "We're playing some of our greatest hits.", date: Date()),
        Events(title: "Baby Shower", venue: "Mom's House", description: "Come wash our baby, they rolled in the mud and we need help cleaning them up.", date: Date()),
    ]
}


struct MessageAlert: Identifiable {
    let id: UUID
    let title: String
    let message: String
}
