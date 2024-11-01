//
//  LatencyMonitor.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/26/24.
//

import Foundation


/// This is a simulation of what real time latency would look like. Monitoring latency patterns is crutial for application as it improves the applications functionality. Low latency is crucial for the app's performance. 
class LatencyMonitor {
    static let shared = LatencyMonitor()
    private init() {}
    
    func measureLatency(for operation: String, completion: @escaping (TimeInterval) -> Void) {
        let startTime = Date()
        
        // Simulate network request
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let endTime = Date()
            let latency = endTime.timeIntervalSince(startTime)
            
            print("Latency for \(operation): \(latency) seconds")
            completion(latency)
        }
    }
}
