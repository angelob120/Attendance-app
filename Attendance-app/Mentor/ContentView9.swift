//
//  ContentView9.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/19/24.
//


import SwiftUI

struct ContentView9: View {
    @State private var isAM = true
    @State private var names: [String] = ["Alice", "Bob", "Charlie", "David", "Eva", "Frank", "Grace", "Henry"]

    var body: some View {
        VStack(spacing: 20) {
            Text("Schedule")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            CustomAMPMToggle(isAM: $isAM)
                .padding(.horizontal)
            
            List {
                ForEach(filteredNames, id: \.self) { name in
                    HStack {
                        Text(name)
                        Spacer()
                        Text(isAM ? "AM" : "PM")
                            .foregroundColor(.gray)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
    
    var filteredNames: [String] {
        // In a real app, you would filter or fetch names based on AM/PM
        
        /// This will be a function for fetching the names from the attendance application
        return names
    }
}

struct CustomAMPMToggle: View {
    @Binding var isAM: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 120, height: 44)
            
            HStack(spacing: 0) {
                AMPMButton(text: "AM", isSelected: isAM) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        isAM = true
                    }
                }
                AMPMButton(text: "PM", isSelected: !isAM) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        isAM = false
                    }
                }
            }
            
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 58, height: 38)
                .offset(x: isAM ? -29 : 29)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isAM)
        }
        .frame(width: 120, height: 44)
    }
}

struct AMPMButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .fontWeight(.medium)
                .frame(width: 60, height: 44)
        }
        .foregroundColor(isSelected ? .blue : .gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView9()
    }
}
