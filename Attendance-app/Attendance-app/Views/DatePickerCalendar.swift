//
//  DatePickerCalendar.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/6/24.
//


import SwiftUI

struct DatePickerCalendar: View {
    @State var selectedDate = Date()
    var body: some View {
        VStack {
            FormattedDate(selectedDate: selectedDate, omitTime: true)
            Divider().frame(height: 1)
            DatePicker("Select Date", selection: $selectedDate,
                       in: ...Date(), displayedComponents: .date)
                .datePickerStyle(.graphical)
            Divider()
        }
    }
}

struct DatePickerCalendar_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerCalendar()
    }
}



struct FormattedDate: View {
    var selectedDate: Date
    var omitTime: Bool = false
    var body: some View {
        Text(selectedDate.formatted(date: .abbreviated, time:
              omitTime ? .omitted : .standard))
            .font(.system(size: 28))
            .bold()
            .foregroundColor(Color.accentColor)
            .padding()
            .animation(.spring(), value: selectedDate)
            .frame(width: 500)
    }
}

struct FormattedDate_Previews: PreviewProvider {
    static var previews: some View {
        FormattedDate(selectedDate: Date())
    }
}
