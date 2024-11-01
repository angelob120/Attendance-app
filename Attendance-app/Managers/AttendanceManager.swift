//
//  AttendanceManager.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/26/24.
//

import Foundation
import Combine

class AttendanceManager {
    func markAttendance(for learnerId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        LatencySimulator.simulateNetworkCall { latency in
            print("Mark Attendance Latency: \(latency) seconds")
            
            // Simulate success or failure
            if latency < 0.5 {
                completion(.success(()))
            } else {
                let error = NSError(domain: "AttendanceManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Network request timed out"])
                completion(.failure(error))
            }
        }
    }
    
    func fetchAttendanceRecord(for learnerId: String, completion: @escaping (Result<String, Error>) -> Void) {
        LatencySimulator.simulateNetworkCall { latency in
            print("Fetch Attendance Record Latency: \(latency) seconds")
            
            // Simulate success or failure
            if latency < 0.5 {
                let record = "Leaner ID: \(employeeId), Status: Present"
                completion(.success(record))
            } else {
                let error = NSError(domain: "AttendanceManager", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch attendance record"])
                completion(.failure(error))
            }
        }
    }
}
