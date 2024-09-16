//
//  FullMonthCalendarView.swift
//  Attendance-app
//
//  Created by AB on 9/16/24.
//

import SwiftUI

// Main calendar view for displaying the full month
struct FullMonthCalendarView: View {
    @State private var selectedDate: Date = Date() // The current selected date, default is today
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter
    private let monthYearFormatter: DateFormatter
    
    // Sample legend data for different types of attendance
    let attendanceStatus: [Int: String] = [
        1: "Attendance", 2: "Attendance", 3: "Attendance", 4: "Tardy", 5: "NoSchool", 7: "Absent", 8: "Attendance",
        9: "Tardy", 10: "Attendance", 12: "NoSchool", 13: "NoSchool", 20: "NoSchool"
    ]
    
    init() {
        // Date formatter to display the day numbers
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        // Formatter to display the full month and year
        monthYearFormatter = DateFormatter()
        monthYearFormatter.dateFormat = "MMMM yyyy"
    }
    
    var body: some View {
        VStack(spacing: 1) {
            // Display month and year at the top
            Text(monthYearFormatter.string(from: selectedDate))
                .font(.title)
                .bold()
            
            // Calendar grid for the full month
            CalendarGridView(selectedDate: $selectedDate, attendanceStatus: attendanceStatus)
            
            // Legend for the status symbols (attendance, tardies, etc.)
            LegendView()
            
            // Spacer between calendar and actions
            Spacer()
            
            // Action buttons for additional functionalities
            ActionButtonView()
            
            // Bottom Navigation Bar
            HStack {
                NavigationLink(destination: ContentView()) {
                    CalendarTabBarButton(icon: "house.fill", text: "Home")
                }
                Spacer()
                NavigationLink(destination: FullMonthCalendarView()) {
                    CalendarTabBarButton(icon: "calendar", text: "Calendar")
                }
                Spacer()
                NavigationLink(destination: ProfileView()) {
                    CalendarTabBarButton(icon: "person.fill", text: "Profile")
                }
                Spacer()
                NavigationLink(destination: EventsView()) {
                    CalendarTabBarButton(icon: "star.fill", text: "Events")
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 1)
        }
    }
}

// Calendar grid showing days of the month
struct CalendarGridView: View {
    @Binding var selectedDate: Date
    let attendanceStatus: [Int: String]
    
    private let calendar = Calendar.current
    
    var body: some View {
        let daysInMonth = getDaysInMonth(for: selectedDate)
        let startOfMonth = getStartOfMonth(for: selectedDate)
        
        VStack {
            // Loops through rows (weeks) and columns (days) to create the calendar grid
            ForEach(0..<6) { row in
                HStack(spacing: 8) {
                    ForEach(0..<7) { col in
                        let day = getDayFor(row: row, column: col, daysInMonth: daysInMonth, startOfMonth: startOfMonth)
                        if day > 0 && day <= daysInMonth {
                            // Each day cell is displayed with attendance status if available
                            DayCellView(day: day, isToday: isToday(day: day), status: attendanceStatus[day])
                                .onTapGesture {
                                    // Update selected date when a day is tapped
                                    selectedDate = getDateForDay(day: day, in: selectedDate)
                                }
                        } else {
                            // Empty space for days outside the valid range of the month
                            Spacer()
                                .frame(width: 40, height: 40)
                        }
                    }
                }
            }
        }
    }
    
    // Helper function to calculate the first day of the month
    func getStartOfMonth(for date: Date) -> Int {
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        return calendar.component(.weekday, from: firstDayOfMonth) - 1 // -1 because weekday starts from 1
    }
    
    // Helper function to calculate the number of days in the current month
    func getDaysInMonth(for date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)
        return range?.count ?? 30
    }
    
    // Helper function to calculate the day for each row and column in the grid
    func getDayFor(row: Int, column: Int, daysInMonth: Int, startOfMonth: Int) -> Int {
        let day = row * 7 + column - startOfMonth + 1
        return day
    }
    
    // Helper function to create a date from the day number
    func getDateForDay(day: Int, in monthDate: Date) -> Date {
        var components = calendar.dateComponents([.year, .month], from: monthDate)
        components.day = day
        return calendar.date(from: components) ?? Date()
    }
    
    // Helper function to check if a given day is today
    func isToday(day: Int) -> Bool {
        let today = calendar.component(.day, from: Date())
        return today == day && calendar.isDate(Date(), equalTo: selectedDate, toGranularity: .month)
    }
}

// View for each day cell in the calendar grid
struct DayCellView: View {
    let day: Int
    let isToday: Bool
    let status: String?
    
    var body: some View {
        VStack(spacing: 4) {
            // Day number with highlight for today
            Text("\(day)")
                .font(.headline)
                .padding(10)
                .background(isToday ? Color.green : Color.clear)
                .foregroundColor(isToday ? Color.white : Color.black)
                .clipShape(Circle())
            
            // Attendance status below the day number
            if let status = status {
                AttendanceStatusView(status: status)
            } else {
                Spacer()
                    .frame(height: 10)
            }
        }
        .frame(width: 40, height: 60)
    }
}

// View for attendance status indicators (absent, tardy, attendance, etc.)
struct AttendanceStatusView: View {
    let status: String
    
    var body: some View {
        switch status {
        case "Absent":
            Circle().fill(Color.red).frame(width: 8, height: 8)
        case "Tardy":
            Circle().fill(Color.yellow).frame(width: 8, height: 8)
        case "Attendance":
            Circle().fill(Color.green).frame(width: 8, height: 8)
        case "NoSchool":
            Image(systemName: "nosign")
                .resizable()
                .frame(width: 10, height: 10)
                .foregroundColor(.gray)
        default:
            EmptyView()
        }
    }
}

// Legend view for attendance status indicators
struct LegendView: View {
    var body: some View {
        HStack(spacing: 16) {
            LegendItem(color: .red, label: "Absences")
            LegendItem(color: .yellow, label: "Tardies")
            LegendItem(color: .green, label: "Attendances")
            LegendItem(image: "nosign", label: "No School")
        }
        .padding()
    }
}

// Single legend item with color or image and label
struct LegendItem: View {
    let color: Color?
    let image: String?
    let label: String
    
    init(color: Color, label: String) {
        self.color = color
        self.image = nil
        self.label = label
    }
    
    init(image: String, label: String) {
        self.color = nil
        self.image = image
        self.label = label
    }
    
    var body: some View {
        HStack {
            if let color = color {
                Circle().fill(color).frame(width: 16, height: 16)
            }
            if let image = image {
                Image(systemName: image)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            Text(label)
                .font(.caption)
        }
    }
}

// Bottom action buttons for Fix Time, Request Time Off, and Detailed Attendance List
struct ActionButtonView: View {
    @State private var viewTabView = true
    @State private var showProfileView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    // Action for fixing time
                }) {
                    HStack {
                        Text("Fix Time")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                }
                
                Button(action: {
                    // Action for requesting time off
                }) {
                    HStack {
                        Text("Request Time Off")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                }
                // Toggle switch is used for navigation. This will like be fixed to be a NavigationStack
                Button(action: {
                    showProfileView.toggle()
                }) {
                    HStack {
                        Text("Detailed Attendance List")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                }
                .sheet(isPresented: $showProfileView, content: {
                    ProfileView()
                })
            }
        }
        .padding()
    }
}

// Bottom tab bar button view
struct CalendarTabBarButton: View {
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


struct FullMonthCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        FullMonthCalendarView()
    }
}
