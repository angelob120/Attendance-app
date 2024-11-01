//
//  CotentMainView.swift
//  Attendance-app
//
//  Created by Keon Johnson on 9/30/24.
//
import Combine
import Foundation
import SwiftData
import SwiftUI

struct ContentMainView: View {
    @Environment(\.modelContext) private var modelCotext
   
    @State private var selectedTab = 0
    
    @State private var currentTheme: ColorTheme = .light
    
    @StateObject private var timerManager = TimerManager()

    let tabs = [
        ("house", "Home"),
        ("calendar", "Calendar"),
        ("person", "Profile"),
        ("bell", "Alerts"),
        ("stop.fill", "Settings")
         
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                
     
            /// Tab view of all the features within the application.
                
                TabView(selection: $selectedTab) {
                    HomeView(currentTheme: $currentTheme, timerManager: timerManager)                         .tag(0)
                    DatePickerCalendar()
                        .tag(1)
                    ProfileView()
                        .tag(2)
                    AlertsView()
                        .tag(3)
                    ThemeSettingsView(currentTheme: $currentTheme)
                        .tag(4)
                    
                    
                    
                }
                .animation(.easeInOut, value: selectedTab)
                .background(currentTheme.backgroundColor)
                
                CustomTabBar(selectedTab: $selectedTab, currentTheme: $currentTheme, tabs: tabs)
                    .frame(height: 60 + geometry.safeAreaInsets.bottom)
                    .offset(y: geometry.safeAreaInsets.bottom > 0 ? 0 : 10)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

 /// A class for creating the functionality of the timer when students check in and check out.

public class TimerManager: ObservableObject {
    @Published public var elapsedTime: TimeInterval = 0
    @Published public var isRunning = false
    
    private var cancellable: AnyCancellable?
    private var startTime: Date?
    
    public init() {}
    
    public func start() {
        guard !isRunning else { return }
        
        print("TimerManager: Starting timer")
        isRunning = true
        startTime = Date()
        
        cancellable = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self, let startTime = self.startTime else { return }
                self.elapsedTime = Date().timeIntervalSince(startTime)
                
                if self.elapsedTime >= 14400 { // 4 hours
                    self.stop()
                }
            }
    }
    
    public func stop() {
        isRunning = false
        cancellable?.cancel()
        startTime = nil
    }
    
    public func reset() {
        stop()
        elapsedTime = 0
    }
    
    public func formattedTime() -> String {
        let hours = Int(elapsedTime) / 3600
        let minutes = (Int(elapsedTime) % 3600) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func updateElapsedTime() {
        guard let startTime = startTime else { return }
        elapsedTime = Date().timeIntervalSince(startTime)
            
        if elapsedTime >= 14400 {
           stop()
        }
        objectWillChange.send()
    }
}

 

 
//import _SwiftData_SwiftUI
// Home view struct consisting of all the features that are in the home menu.
public struct HomeView: View {
    @Binding var currentTheme: ColorTheme // Add this binding for the current theme
    // This binding is being called from a enum switch statement for changing the background and other scenes to different color variations.
    @State private var isPressed = false
    @State private var selectedDate = Date()
    @State private var isExpanded = false
    @State private var elapsedTime: TimeInterval = 0
    @StateObject var timerManager: TimerManager
    
    // Make sure this initializer is not marked as private
//    init(currentTheme: Binding<ColorTheme>, timerManager: TimerManager) {
//        self._currentTheme = currentTheme
//        self.timerManager = timerManager
//    }
/// This is to monitor Latency within the application, It doesn't provide real time metrix without an API server for request.
    ///
    /// Between CloudKit and XCode, this will sycronize the application to monitor real time Latency ensure that the information and time can accurately corrolate when time is monitored.
    ///
    ///
    ///
    class AttendanceManager: ObservableObject {
        @Published var lastLatency: TimeInterval?

        func markAttendance(for learnerId: String) {
            let startTime = Date()
            
            // Simulate network delay (e.g., between 200ms and 1500ms)
            let simulatedDelay = Double.random(in: 0.2...1.5)
            
            DispatchQueue.global().asyncAfter(deadline: .now() + simulatedDelay) {
                let endTime = Date()
                DispatchQueue.main.async {
                    self.lastLatency = endTime.timeIntervalSince(startTime)
                    print("Attendance marked for learner \(learnerId). Latency: \(self.lastLatency ?? 0) seconds")
                }
            }
        }
    }
 
    
    @StateObject private var attendanceManager = AttendanceManager()
 
    public init(currentTheme: Binding<ColorTheme>, timerManager: TimerManager) {
        self._currentTheme = currentTheme
        self._timerManager = StateObject(wrappedValue: timerManager)
    }
    
    
   // @State private var timer: Timer?
//    @State private var countdownDuration: TimeInterval = 60
//    @State private var remainingTime: TimeInterval = 60
    @State private var isTimerRunning = false
    @State private var buttonPressCount = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    public var body: some View {
           VStack {
               ZStack {
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
                               Text("Select Date") // Customize this label as needed
                           }
                       )
                       .disclosureGroupStyle(CustomDisclosureStyle())
                       
                       VStack {
                           Text(selectedDate, format: .dateTime.weekday())
                               .font(.subheadline)
                       }
                       .padding(.vertical, 5)
                       
                       WeekView2(selectedDate: $selectedDate) // Assuming you have this view
                   }
                   .padding()
                   .background(RoundedRectangle(cornerRadius: 20).fill(currentTheme.backgroundColor)) // Use theme's background color
                   .shadow(radius: 10)
                   .transition(.move(edge: .top).combined(with: .opacity))
                   .frame(maxWidth: .infinity, maxHeight: isExpanded ? 600 : 300)
                   .padding()
               }

/*               Text(timeString(from: elapsedTime))
 
 
 
 
 */ // Assuming you have a timeString function
               
               Text(timerManager.formattedTime())
               
                   .font(.largeTitle)
                   .padding()

               ZStack {
                   Color.white.edgesIgnoringSafeArea(.all)

                   Button(action: {
                       // Existing timer logic
                       if timerManager.isRunning {
                           timerManager.stop()
                       } else {
                           timerManager.start()
                       }

                       // Call to mark attendance
                       attendanceManager.markAttendance(for: "LEARNER001")
                   }) {
                       ZStack {
                           Circle()
                               .fill(currentTheme.tabBarColor.opacity(0.7)) // Use theme's tab bar color with opacity
                               .frame(width: 250, height: 250)

                           Image("MSUIcon") // Replace with your asset name
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                               .frame(width: 170, height: 170)
                               .opacity(0.9) // Keep opacity for the image

                           VStack {
                               Image(systemName: timerManager.isRunning ? "hand.point.up.fill" : "play.fill")
                                   .font(.system(size: 40))
                                   .foregroundColor(.white) // No opacity

                               Text(timerManager.isRunning ? "Check In" : "Check In") // Change text as needed
                                   .font(.headline)
                                   .foregroundColor(.white) // No opacity

                               Text(timeString(from: timerManager.elapsedTime)) // Display elapsed time from the timer manager
                                   .font(.system(size: 24, weight: .bold))
                                   .foregroundStyle(.white)
                                   .padding(.top, 10)
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

               // Display latency information
               if let latency = attendanceManager.lastLatency {
                   Text("Last operation latency: \(latency, specifier: "%.3f") seconds")
                       .font(.caption)
                       .foregroundColor(currentTheme.textColor) // Use your theme's text color
                       .padding(.top, 10)
               }
           }
           // Timer logic (if applicable)...
           .onReceive(timer) { _ in // Assuming you have a timer defined elsewhere in your code
               if isTimerRunning && elapsedTime < 14400 { // Example condition for maximum elapsed time (4 hours)
                   elapsedTime += 1
               } else if elapsedTime >= 14400 {
                   isTimerRunning = false
               }
           }
       }
   
 
 

    /// This function must be called into the button action for fuctionality
    private func timeString(from timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02i:%02i", hours, minutes, seconds)
    }
    
    private func startTimer() {
        print("Starting timer")
      Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer
            in
            if self.elapsedTime < 4 * 60 * 60 /* 14400 */ {
                self.elapsedTime += 1
                print("Elapsed time: \(self.elapsedTime)")
            } else {
                timer.invalidate()
                self.isTimerRunning = false
                print("Timer stopped")
            }
        }
    }
    
/// Used as a placeholder for actual button press.
    private func stopTimer() {
        print("Stopping timer")
        isTimerRunning = false
      //  timer?.invalidate()
      //  timer = nil
    }
}
 
struct CustomTabBar: View {
    @Binding var selectedTab: Int
    @Binding var currentTheme: ColorTheme
    let tabs: [(String, String)]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(0..<tabs.count, id: \.self) { index in
                    TabItem6(
                        imageName: tabs[index].0,
                        title: tabs[index].1,
                        isSelected: selectedTab == index,
                        theme: currentTheme
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
            
            Rectangle()
                .fill(Color.clear)
                .frame(height: 20 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)) /// Just forget UIApplication, because window is deprecated, use just .frame(height: Int)
            /// Remove this once complete.
            ///
        }
        .background(currentTheme.tabBarColor)
    }
}
 

struct TabItem6: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    let theme: ColorTheme
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: imageName)
                .foregroundStyle(isSelected ? theme.tabBarTextColor : theme.tabBarTextColor.opacity(0.5))
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
                .fill(isSelected ? theme.selectedTabColor.opacity(theme.selectedTabOpacity) : Color.clear)
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

 
 
#Preview {
    ContentMainView()
}
 

