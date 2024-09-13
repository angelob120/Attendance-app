//
//  eventsView.swift
//  Attendance-app
//
//  Created by AB on 9/13/24.
//

import SwiftUI

struct EventRow: View {
    var body: some View {
        HStack {
            VStack {
                Text("SEP:3")
                    .font(.headline)
                    .foregroundColor(.gray)
                Text("WENS")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(width: 60)
            
            VStack(alignment: .leading) {
                Text("Event 1:")
                    .font(.headline)
                    .padding(.bottom, 2)
                Text("Networking Event")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Placeholder for more options or action menu
            Image(systemName: "ellipsis")
                .foregroundColor(.gray)
                .padding(.trailing)
        }
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 8)
                        .fill(Color.green.opacity(0.1)))
        .padding(.horizontal)
    }
}

struct EventsTabView: View {  // Avoiding conflicting names here
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Events:")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Image(systemName: "line.horizontal.3.decrease")
                        .padding()
                }
                .padding()
                
                List(0..<6) { _ in
                    EventRow()
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Events")
                        .font(.title3)
                        .bold()
                }
            }
        }
    }
}

struct MainContentView: View {  // Renamed this from 'ContentView' to avoid conflict
    var body: some View {
        TabView {
            Text("Home") // Placeholder for Home tab
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            EventsTabView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Events")
                }
            
            Text("Profile") // Placeholder for Profile tab
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            
            Text("Star") // Placeholder for Star tab
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }
        }
    }
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            MainContentView()  // Correct reference to renamed struct
        }
    }
}
