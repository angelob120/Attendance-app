//
//  CirclesTopView.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/11/24.
//

import SwiftUI


struct CirclesTopView: View {

    
    var body: some View {
        VStack() {
            CircularProgressView(progress: 0.55)
            
            
            CircularProgressView(progress: 0.85)
                .scaleEffect(0.75)
            
            Spacer()
            
        }
        .padding()
    }
}




struct CircularProgressView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray4), lineWidth: 20)
            Circle()
                .trim(from: 0, to: CGFloat(self.progress))
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
        }
        .rotationEffect(Angle(degrees: -90))
        .frame(width: 200, height: 200)
    }
}


#Preview {
    CirclesTopView()
}
