//
//  ContentView.swift
//  Attendance-app
//
//  Created by AB on 10/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate: Date = Date()  // State to track the selected date
    @State private var isPunchedIn: Bool = false  // State for punch in/out
    @State private var timeElapsed: String = "00:00"  // Placeholder for the timer
    @State private var weekOffset: Int = 0  // Offset for swiping between weeks
    @State private var dragOffset: CGFloat = 0  // For tracking the drag gesture
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter
    private let dayOfWeekFormatter: DateFormatter
    private let monthFormatter: DateFormatter  // Formatter for the month name
    
    init() {
        // Set up a date formatter to display the day number
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"  // For the day number
        
        // Formatter for day of the week (like Sun, Mon)
        dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.dateFormat = "EEE"  // For the day of the week (short format)
        
        // Formatter for the month name
        monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM yyyy"  // For displaying the current month (e.g., "September 2024")
    }
    
    var body: some View {
        VStack {
            // Week Calendar View
            VStack {
                HStack {
                    // Display the current month and year
                    Text(monthFormatter.string(from: firstDayOfTheWeek(weekOffset: weekOffset)))
                        .font(.title2)
                        .bold()
                        .padding(.leading, 16)
                    Spacer()
                }
                
                Divider()  // Adds a line separator
                
                // Swipable Week View with two weeks visible during the drag
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        // Current week
                        WeekView(dates: weekDays(weekOffset: weekOffset),
                                 selectedDate: $selectedDate,
                                 dateFormatter: dateFormatter,
                                 dayOfWeekFormatter: dayOfWeekFormatter)
                            .frame(width: geometry.size.width)
                        
                        // Next or Previous week (based on drag direction)
                        WeekView(dates: weekDays(weekOffset: weekOffset + (dragOffset < 0 ? 1 : -1)),
                                 selectedDate: $selectedDate,
                                 dateFormatter: dateFormatter,
                                 dayOfWeekFormatter: dayOfWeekFormatter)
                            .frame(width: geometry.size.width)
                    }
                    .offset(x: dragOffset)
                    .gesture(DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            // Check if the swipe is far enough to change the week
                            let threshold = geometry.size.width / 2
                            if value.translation.width < -threshold {
                                // Swipe left (next week)
                                withAnimation(.easeInOut) {
                                    weekOffset += 1
                                    dragOffset = -geometry.size.width  // Move fully offscreen
                                    dragOffset = 0  // Reset
                                }
                            } else if value.translation.width > threshold {
                                // Swipe right (previous week)
                                withAnimation(.easeInOut) {
                                    weekOffset -= 1
                                    dragOffset = geometry.size.width  // Move fully offscreen
                                    dragOffset = 0  // Reset
                                }
                            } else {
                                // Not far enough, snap back
                                withAnimation(.easeInOut) {
                                    dragOffset = 0
                                }
                            }
                        }
                    )
                }
                .frame(height: 100)  // Adjust the height as needed for the week view
            }
            .padding(.top, 16)
            
            // Profile Section
            HStack {
                Image(systemName: "person.circle.fill")  // Placeholder for profile image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.leading, 16)
                
                Text("Good Morning Angelo!")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading, 8)
                
                Spacer()
            }
            .padding(.vertical, 16)
            
            // Timer and Punch Button
            VStack {
                ZStack {
                    Circle()
                        .trim(from: 0, to: isPunchedIn ? 1 : 0)
                        .stroke(isPunchedIn ? Color.green : Color.gray, lineWidth: 10)
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 1), value: isPunchedIn)
                    
                    Text(timeElapsed)
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.black)
                }
                .padding()
                
                Button(action: {
                    isPunchedIn.toggle()
                }) {
                    Text(isPunchedIn ? "Punch Out" : "Punch In")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200)
                        .background(Color.green)
                        .cornerRadius(8)
                }
            }
            .padding(.top, 24)
            
            Spacer()
            
            // Bottom Navigation Bar
            HStack {
                NavigationLink(destination: ContentView()) {
                    TabBarButton(icon: "house.fill", text: "Home")
                }
                Spacer()
                NavigationLink(destination: FullMonthCalendarView()) {
                    TabBarButton(icon: "calendar", text: "Calendar")
                }
                Spacer()
                NavigationLink(destination: ProfileView()) {
                    TabBarButton(icon: "person.fill", text: "Profile")
                }
                Spacer()
                NavigationLink(destination: EventsView()) {
                    TabBarButton(icon: "star.fill", text: "Events")
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    } // <-- Added missing closing brace
    
    // Function to get the first day of the week based on the current week offset
    func firstDayOfTheWeek(weekOffset: Int) -> Date {
        let today = Date()
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        return calendar.date(byAdding: .day, value: weekOffset * 7, to: startOfWeek)!
    }

    // Function to get the dates for the current week (starting from Sunday) and offset by `weekOffset`
    func weekDays(weekOffset: Int) -> [Date] {
        let startOfWeek = firstDayOfTheWeek(weekOffset: weekOffset)
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
    
    // Helper function to compare two dates (ignoring time)
    func isSameDay(date1: Date, date2: Date) -> Bool {
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}

// Separate view for displaying each week's dates
struct WeekView: View {
    let dates: [Date]
    @Binding var selectedDate: Date
    let dateFormatter: DateFormatter
    let dayOfWeekFormatter: DateFormatter
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(dates, id: \.self) { date in
                VStack {
                    Text(dayOfWeekFormatter.string(from: date)) // Day of the week (e.g., "Sun")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(dateFormatter.string(from: date)) // Date number (e.g., "17")
                        .font(.headline)
                        .padding(10)
                        .background(isSameDay(date1: selectedDate, date2: date) ? Color.green : Color.clear)
                        .foregroundColor(isSameDay(date1: selectedDate, date2: date) ? Color.white : (isSameDay(date1: Date(), date2: date) ? Color.green : Color.black))
                        .clipShape(Circle())
                }
                .onTapGesture {
                    selectedDate = date  // Update the selected date when tapped
                }
            }
        }
    }
    
    // Helper function to compare two dates
    func isSameDay(date1: Date, date2: Date) -> Bool {
        Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}

struct TabBarButton: View {
    let icon: String
    let text: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.green)
            Text(text)
                .font(.caption)
                .foregroundColor(.green)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
