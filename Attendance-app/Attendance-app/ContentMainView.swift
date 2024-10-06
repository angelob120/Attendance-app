//
//  CotentMainView.swift
//  Attendance-app
//
//  Created by Keon Johnson on 9/30/24.
//

import SwiftUI

struct ContentMainView: View {
    @State private var selectedTab = 0
    
    let tabs = [
        ("house", "Home"),
        ("magnifyingglass", "Search"),
        ("heart", "Favorites"),
        ("person", "Profile")
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tag(0)
                    Text("Search")
                        .tag(1)
                    Text("Favorites")
                        .tag(2)
                    Text("Profile")
                        .tag(3)
                }
                .animation(.easeInOut, value: selectedTab)
                
                CustomTabBar(selectedTab: $selectedTab, tabs: tabs)
                    .frame(height: 60 + geometry.safeAreaInsets.bottom)
                    .offset(y: geometry.safeAreaInsets.bottom > 0 ? 0 : 10)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
 


struct HomeView: View {
    @State private var isPressed = false
    @State private var selectedDate = Date()
    
    
  //  @Binding var selectedDate: Date
    @State private var isExpanded = false
 //   @State private var selectedDate = Date()
    
    let name = String()
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?
    @State private var coundownDuration: TimeInterval = 60
    @State private var remaingingTime: TimeInterval = 60
    
    
    
    var body: some View {
        VStack {
//            CalendarView(selectedDate: $selectedDate)
//                .frame(height: 350)
            
            ZStack {
                VStack {
                    VStack {
                        DisclosureGroup(
                            isExpanded: $isExpanded,
                            content: {
                                if isExpanded {
                                    VStack {
                                        DatePicker("Select a date", selection: $selectedDate, displayedComponents: [.date])
                                            .datePickerStyle(GraphicalDatePickerStyle())
                                            .frame(height: 300)
                                            .padding(.top, 10)
                                            .transition(.move(edge: .top))
                                            .zIndex(1)
                                    }
                                }
                            },
                            label: {
                                //  Text("Select Date") // You can customize this label
                            }
                        )
                        .disclosureGroupStyle(CustomDisclosureStyle())
                        
                        VStack {
                            Text(selectedDate, format: .dateTime.weekday())
                                .font(.subheadline)
                        }
                        .padding(.vertical, 5)
                        
                        WeekView2(selectedDate: $selectedDate)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.green))
                    .shadow(radius: 10)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .frame(maxWidth: .infinity, maxHeight: isExpanded ? 600 : 300)
                    .padding()
                }
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            Text(timeString(from: remaingingTime))
                .font(.largeTitle)
                .padding()
            
            
            
            
            
            
            
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                Button(action: {
                    // Add your button action here
                    print("Circle button tapped")
                }) {
                    ZStack {
                        // Green circle with opacity
                        Circle()
                            .fill(Color.green.opacity(0.7))
                            .frame(width: 250, height: 250)
                        
                        // Asset image with opacity
                        Image("MSUIcon") // Replace with your asset name
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 170)
                        //  .clipShape(Circle())
                            .opacity(0.9) // Keep opacity for the image
                        
                        // SF Symbol and Text in a VStack
                        VStack {
                            Image(systemName: "hand.point.up.fill") // Replace with your desired SF Symbol
                                .font(.system(size: 40))
                                .foregroundColor(.white) // No opacity
                            
                            Text("Check In") // Change text as needed
                                .font(.headline)
                                .foregroundColor(.white) // No opacity
                        }
                    }
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                    
                    .animation(.easeInOut(duration: 0.2), value: isPressed)
                    
                }
                .buttonStyle(PlainButtonStyle())
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            isPressed = true
                        }
                        .onEnded { _ in
                            isPressed = false
                        }
                )
            }
        }
    }
    
    
    private func toggleTimer() {
        if timer == nil {
            // Start the timer
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if remaingingTime > 0 {
                    remaingingTime -= 1
                }
            }
        } else {
            // Stop the timer
            
            timer?.invalidate()
            timer = nil
           // elapsedTime = 0
            remaingingTime = coundownDuration;
        }
    }
    
    
    private func timeString(from timeInterval: TimeInterval) -> String {
           let hours = Int(timeInterval) / 3600
           let minutes = Int(timeInterval) / 60 % 60
           let seconds = Int(timeInterval) % 60
           return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
       }
    
    
    
    
    
    
}



 
struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let tabs: [(String, String)]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(0..<tabs.count, id: \.self) { index in
                    TabItem6(
                        imageName: tabs[index].0,
                        title: tabs[index].1,
                        isSelected: selectedTab == index
                    )
                    .onTapGesture {
                        selectedTab = index
                    }
                    if index != tabs.count - 1 {
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 12)
            
            // Add extra padding at the bottom
            Rectangle()
                .fill(Color.clear)
                .frame(height: 20 + (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0))        }
        .background(
            Color.tabBarGreen
                .edgesIgnoringSafeArea(.bottom)
                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: -3)
        )
    }
}

struct TabItem6: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: imageName)
                .font(.system(size: 22))
            
            // Condition for tabItem session, if user tabs on the icons tab, the HStack will appear.
            if isSelected {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(1)
                    .fixedSize()
            }
        }
        .frame(height: 44)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, isSelected ? 16 : 12)
        .background(
            Capsule()
                .fill(isSelected ? Color.selectedTabGreen : Color.clear)
        )
        .foregroundColor(isSelected ? .white : .white.opacity(0.7))
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

extension Color {
    static let tabBarGreen = Color(red: 76/255, green: 175/255, blue: 80/255)
    static let selectedTabGreen = Color(red: 56/255, green: 142/255, blue: 60/255)
}

/// Custom UIApplication extension which is used to create a safe area.

extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}


 









struct ContentMainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentMainView()
    }
}
