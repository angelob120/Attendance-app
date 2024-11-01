//
//  AttendanceManagerClass.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/26/24.
//
 

//import Foundation
//
//public class AttendanceManager: ObservableObject {
//    @Published var lastLatency: TimeInterval?
//
//    func markAttendance(for learnerId: String) {
//        let startTime = Date()
//        // Simulating a network call
//        DispatchQueue.global().asyncAfter(deadline: .now() + Double.random(in: 0.1...1.0)) {
//            let endTime = Date()
//            DispatchQueue.main.async {
//                self.lastLatency = endTime.timeIntervalSince(startTime)
//                print("Attendance marked for learner \(learnerId). Latency: \(self.lastLatency ?? 0) seconds")
//            }
//        }
//    }
//}
