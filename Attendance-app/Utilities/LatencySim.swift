//
//  LatencySim.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/26/24.
//

import Foundation

class LatencySimulator {
    static func simulateNetworkCall(completion: @escaping (TimeInterval) -> Void) {
        let startTime = Date()
        
        // Simulate network delay (between 0.1 and 1 second)
        let delay = Double.random(in: 0.1...1.0)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
            let endTime = Date()
            let latency = endTime.timeIntervalSince(startTime)
            completion(latency)
        }
    }
}
