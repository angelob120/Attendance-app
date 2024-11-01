//
//  StudentAttendanceCalendarDetailsView.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/29/24.
//


//import SwiftUI
//
//// Main View for displaying student attendance calendar details
//struct StudentAttendanceCalendarDetailsView: View {
//    @State private var monthYear: String = "" // Holds the current month and year as a string
//    @State private var dayoutsForSelectedMonth: [Dayout] = [] // Stores dayouts for the selected month
//    @State private var attendances: [String: Attendance] = [:] // Stores attendance records
//    @State private var selectedDate: Date = Date() // Holds the currently selected date
//    
//    let student: User // The student whose attendance is being tracked
//    let calendar = Calendar.current // Current calendar for date calculations
//    
//    var body: some View {
//        VStack {
//            // Display the current month and year
//            Text(monthYear)
//                .font(.title)
//                .padding(.top, 20)
//            
//            // Date picker for selecting a date
//            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
//                .labelsHidden() // Hide the label
//                .onChange(of: selectedDate) { newDate in
//                    loadCalendar(with: newDate) // Load data when date changes
//                }
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color(UIColor.systemGray5)) // Background color
//                .cornerRadius(8)
//            
//            // Attendance statistics view
//            AttendanceStatsView(attendances: attendances)
//                .padding(.top, 10)
//        }
//        .onAppear(perform: loadData) // Load data when the view appears
//        .navigationTitle("Fixed Schedule") // Navigation title
//        .navigationBarItems(trailing: Button("Today") { // Button to show today's date
//            selectedDate = Date() // Reset to today's date
//            loadCalendar(with: Date()) // Load data for today
//        })
//        .background(Color(UIColor.systemBackground)) // Background color
//    }
//    
//    // Load data for the current month
//    private func loadData() {
//        updateMonthYearLabel(with: selectedDate) // Update the month/year label
//        loadDayoutsIn(monthOf: selectedDate) { // Load dayouts
//            let monthRange = calendar.monthDates(for: selectedDate) // Get the range of the current month
//            loadAttendances(between: monthRange.start, and: monthRange.end) // Load attendance records
//        }
//    }
//    
//    // Update the month and year label
//    private func updateMonthYearLabel(with date: Date) {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM, yyyy" // Format to "Month, Year"
//        monthYear = formatter.string(from: date).uppercased() // Set the formatted string
//    }
//    
//    // Load dayouts for the given month
//    private func loadDayoutsIn(monthOf date: Date, completionHandler: @escaping () -> Void) {
//        guard let currentClassroom = Classroom.current else { return }
//        let monthRange = calendar.monthDates(for: date) // Get the range of the month
//        
//        ClassroomCloudKit.shared.dayouts(for: currentClassroom, between: monthRange.start, and: monthRange.end) { (dayouts, _) in
//            self.dayoutsForSelectedMonth = dayouts // Update dayouts
//            completionHandler() // Call the completion handler
//        }
//    }
//    
//    // Load attendance records between two dates
//    private func loadAttendances(between firstDate: Date, and lastDate: Date) {
//        ClassroomCloudKit.shared.attendances(for: student, between: firstDate, and: lastDate) { (attendances, error) in
//            guard error == nil else { return } // Handle error
//            
//            // Create a dictionary of attendance records with dates as keys
//            self.attendances = Dictionary(uniqueKeysWithValues: attendances.map { (formatter.string(from: $0.entryDate), $0) })
//        }
//    }
//    
//    // Load calendar for the selected date
//    private func loadCalendar(with date: Date) {
//        updateMonthYearLabel(with: date) // Update the month/year label
//        loadDayoutsIn(monthOf: date) { // Load dayouts
//            let monthRange = calendar.monthDates(for: date) // Get the range of the selected month
//            loadAttendances(between: monthRange.start, and: monthRange.end) // Load attendance records
//        }
//    }
//}
//
//// AttendanceStatsView component for displaying attendance statistics
//struct AttendanceStatsView: View {
//    var attendances: [String: Attendance] // Attendance records
//
//    var body: some View {
//        VStack {
//            // Display statistics for attendance statuses
//            Text("Absences: \(attendanceCount(for: .missed))") // Translated from "Faltas"
//                .foregroundColor(.red)
//            Text("Tardies: \(attendanceCount(for: .firstTolerance))") // Translated from "Atrasos"
//                .foregroundColor(.orange)
//            Text("Present: \(attendanceCount(for: .inTime))") // Translated from "Presenças"
//                .foregroundColor(.green)
//        }
//    }
//
//    // Count attendance based on status
//    private func attendanceCount(for status: Attendance.Status) -> Int {
//        return attendances.values.filter { $0.status == status }.count
//    }
//}
//
//// Extend Calendar with helper methods
//extension Calendar {
//    // Get the start and end dates of the month for a given date
//    func monthDates(for date: Date) -> (start: Date, end: Date) {
//        let range = self.range(of: .day, in: .month, for: date)! // Get the range of days in the month
//        let startOfMonth = self.date(from: self.dateComponents([.year, .month], from: date))! // Get the start date of the month
//        let endOfMonth = self.date(byAdding: .day, value: range.count - 1, to: startOfMonth)! // Calculate the end date
//        return (startOfMonth, endOfMonth) // Return start and end dates
//    }
//}
//
//// Preview for SwiftUI
//struct StudentAttendanceCalendarDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            StudentAttendanceCalendarDetailsView(student: User.example) // Replace with an example User
//        }
//    }
//}
