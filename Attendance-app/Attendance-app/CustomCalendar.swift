
import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    @State private var isExpanded = false
 //   @State private var selectedDate = Date()
    
    let name = String()
    
    var body: some View {
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
                .background(RoundedRectangle(cornerRadius: 10).stroke())
                .frame(maxWidth: .infinity, maxHeight: isExpanded ? 600 : 300)
                .padding()
            }
        }
    }
}


struct WeekView2: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        HStack {
            // Days of the week calendar
            ForEach(0..<7) { index in
                let date = Calendar.current.date(byAdding: .day, value: index - Calendar.current.component(.weekday, from: selectedDate) + 1, to: selectedDate)!
                VStack {
                    Text(date, format: .dateTime.weekday(.narrow))
                        .font(.caption)
                    Text(date, format: .dateTime.day())
                        .font(.caption2)
                }
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(date.startOfDay == selectedDate.startOfDay ? Color.blue.opacity(0.3) : Color.clear)
                .cornerRadius(5)
                .onTapGesture {
                    selectedDate = date
                }
            }
        }
    }
}

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}

 


struct destinyDesignView: View {
    var body: some View {
        Text("")
    }
}



 


struct CustomDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button(
                action: { withAnimation { configuration.isExpanded.toggle() } },
                label: {
                    HStack {
                        configuration.label
                        Spacer()
                        Image(systemName: "arrow.down.left.arrow.up.right") // Replace with your desired SF Symbol
                            .rotationEffect(.degrees(configuration.isExpanded ? 180 : 0))
                    }
                }
            )
            .buttonStyle(PlainButtonStyle())
            
            if configuration.isExpanded {
                configuration.content
            }
        }
    }
}
