//
//  CircleBarView.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/11/24.
//

import SwiftUI


struct CircleBarView: View {
    
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .stroke(Color(.systemGray4), lineWidth: 20)
                Circle()
                    .trim(from: 0, to: 0.55)
                    .stroke(Color.green, lineWidth: 20)
            }
            .frame(width: 200, height: 200)
            
            Path() { path in
                path.addArc(center: CGPoint(x: 100, y: 100),
                            radius: 90,
                            startAngle: Angle(degrees: 0.0),
                            endAngle: Angle(degrees: 360 * 0.55),
                            clockwise: false)
            }
            .stroke(Color.green, lineWidth: 20)
            .frame(width: 200, height: 200)
            
            
            Spacer()
        }
    }
}






#Preview {
    CircleBarView()
}


/// Fatal Error ran in this code, future examination is needed.
