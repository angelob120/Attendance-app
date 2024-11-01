//
//  AlertsView.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/23/24.
//



/// This view is placeholder data which will be used for future purposes pertaining to the current application.
import SwiftUI

let months = ["December", "November", "October", "September", "August", "July", "June", "May", "April", "March", "February", "January"]

struct Alert: Identifiable {
    let id = UUID()
    let month: String
    let description: String
    let date: String
}

struct AlertsView: View {
    @State private var currentDate = Date()
    @State private var alerts: [String: [Alert]] = [:]
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var currentYear: Int {
        Calendar.current.component(.year, from: currentDate)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach(months, id: \.self) { month in
                        if let monthAlerts = alerts[month], !monthAlerts.isEmpty {
                            Section(header:
                                HStack {
                                    Text(month).font(.title2).fontWeight(.bold)
                                    Spacer()
                                    Button("Clear All") {
                                        clearAlerts(for: month)
                                    }
                                    .foregroundColor(.red)
                                }
                            ) {
                                ForEach(monthAlerts) { alert in
                                    AlertRow(alert: alert)
                                }
                                .onDelete { indexSet in
                                    deleteAlerts(at: indexSet, for: month)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Alerts")
        }
        .onAppear(perform: generateAlerts)
        .onReceive(timer) { _ in
            self.currentDate = Date()
        }
    }
    
    func generateAlerts() {
        for month in months {
            let numberOfAlerts = Int.random(in: 3...7)
            alerts[month] = (0..<numberOfAlerts).map { _ in
                Alert(month: month,
                      description: randomDescription(),
                      date: randomDate(for: month))
            }
        }
    }
    
    func randomDescription() -> String {
        let descriptions = ["New message received", "Battery low", "Software update available", "Weather alert", "Calendar reminder"]
        return descriptions.randomElement() ?? "Alert"
    }
    
    func randomDate(for month: String) -> String {
        let monthIndex = months.firstIndex(of: month)!
        let day = Int.random(in: 1...28)
        return "\(monthIndex + 1)/\(day)/\(currentYear)"
    }
    
    func deleteAlerts(at offsets: IndexSet, for month: String) {
        alerts[month]?.remove(atOffsets: offsets)
    }
    
    func clearAlerts(for month: String) {
        alerts[month]?.removeAll()
    }
}

struct AlertRow: View {
    let alert: Alert
    
    var body: some View {
        HStack {
            Image(systemName: "bell.fill")
                .foregroundColor(.black)
            
            VStack(alignment: .leading) {
                Text(alert.description)
                    .font(.headline)
                Text("This is a placeholder description for the alert.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(alert.date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct AlertsView_Previews: PreviewProvider {
    static var previews: some View {
        AlertsView()
    }
}
