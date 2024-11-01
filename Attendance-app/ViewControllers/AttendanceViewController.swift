//
//  AttendanceViewController.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/26/24.
//

import UIKit

class AttendanceViewController: UIViewController {
    let attendanceManager = AttendanceManager()
    
    func markAttendance() {
        attendanceManager.markAttendance(for: "LEARNER001") { result in
            switch result {
            case .success:
                print("Attendance marked successfully")
            case .failure(let error):
                print("Failed to mark attendance: \(error.localizedDescription)")
            }
        }
    }
    
    /// Simulation record of a function that fetches student records. In this case Learner 1 will be our student base for the time as CloudKit is being implemented. 
    func fetchAttendanceRecord() {
        attendanceManager.fetchAttendanceRecord(for: "LEARNER001") { result in
            switch result {
            case .success(let record):
                print("Fetched record: \(record)")
            case .failure(let error):
                print("Failed to fetch record: \(error.localizedDescription)")
            }
        }
    }
}
