//
//  MentorReportView.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/23/24.
//


import SwiftUI


struct mentorReportView: View {
    
    
    @State private var mentorCorhert = 0
    @State private var mentorName = "Delon"
    
    
    
    
    var body: some View {
        VStack {
            
            Text("Mentor Name: \(mentorName)")
                .font(.headline)
            
            Picker("Mentor Correctness", selection: $mentorCorhert) {
                Text("AM").tag(0)
                Text("PM").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
}


#Preview {
    mentorReportView()
}
