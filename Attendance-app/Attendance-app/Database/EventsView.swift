//
//  File.swift
//  Attendance-app
//
//  Created by AB on 9/16/24.
//

import SwiftUI

struct EventsView: View {
    var events = Array(repeating: Event(date: "SEP:3", day: "WENS", title: "Event 1:", subtitle: "Networking Event"), count: 7)
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("Events:")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading, 16)
                .padding(.top, 20)
            
            // Header
            HStack {
                Text("Date")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("Event")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Image(systemName: "arrow.up.arrow.down")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 16)
            
            // Event List
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(events.indices, id: \.self) { index in
                        EventRow(event: events[index], isHighlighted: index == 0) // Highlight the first event
                    }
                }
                .padding(.horizontal, 19)
                .padding(.top, 10)
            }
            
            Spacer()
            
            // Bottom Navigation Bar
            HStack {
                NavigationLink(destination: ContentMainView()) {
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
        .navigationBarTitle("Events", displayMode: .inline)
    }
}

struct Event: Identifiable {
    var id = UUID()
    var date: String
    var day: String
    var title: String
    var subtitle: String
}

struct EventRow: View {
    let event: Event
    let isHighlighted: Bool
    
    var body: some View {
        HStack {
            // Date and Day
            VStack(alignment: .leading) {
                Text(event.date)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(event.day)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 10)
            
            Spacer()
            
            // Event Title and Subtitle
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.headline)
                    .fontWeight(isHighlighted ? .bold : .regular)
                    .foregroundColor(isHighlighted ? Color.white : Color.black)
                
                Text(event.subtitle)
                    .font(.subheadline)
                    .foregroundColor(isHighlighted ? Color.white.opacity(0.8) : Color.gray)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 50)
            .background(isHighlighted ? Color.green : Color(UIColor.systemGray6))
            .cornerRadius(12)
            
            Spacer()
            
            // Options Button
            Button(action: {
                // Action for more options
            }) {
                Image(systemName: "ellipsis")
                    .foregroundColor(isHighlighted ? Color.white : Color.gray)
            }
        }
        .padding(.vertical, 5)
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
